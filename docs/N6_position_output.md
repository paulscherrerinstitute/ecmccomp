# N6 periodic position output

Apply `Drive-Generic-PositionOutput` after the motor and before EtherCAT
configuration is applied. It currently supports only the N6 open-loop stepper
setup commissioned with FIR-v2542-B1080909. It requires the companion ecmccfg
`N6-1-1-1-S_OPT` descriptor with `RAW_POS=1`.

```text
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd "HW_DESC=N6-1-1-1-S_OPT,OPT='RAW_POS=1'"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Motor-Generic-2Phase-Stepper,MACROS='I_MAX_MA=400,I_STDBY_MA=100,STEPS=200,INV_DIR=0'"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Drive-Generic-PositionOutput,MACROS='FULL_STEPS=100,OUTPUT=1,ARM=1'"
```

With `RAW_POS=1`, use `positionActual01` (`6063`, the fine open-loop counter)
for axis feedback and retain native velocity units. The output uses
`positionActualScaled01` (`6064`), whose units become coarse. The corresponding
PVs are `Enc01-PosAct` for feedback and `Enc01-PosScaled` for scaled position. The tested
200-full-step motor uses 3,276,800 raw counts/revolution; other motor step
counts require their corresponding axis scaling. This is generated open-loop
position, not measured rotor position. Motor `INV_DIR=0` is required by this
configuration; the component rejects an inverted motor setting. Full-step
engineering units use numerator 200 and denominator 3276800 on both drive
and encoder; degrees use numerator 360 instead.

| Macro | Default | Meaning |
| --- | --- | --- |
| `FULL_STEPS` | `100` | Interval in full motor steps |
| `OUTPUT` | `1` | Physical digital output 1, 2 or 3 |
| `ARM` | `0` | Initial gate: 0 disabled, 1 enabled |
| `N6_IO_24V` | `0` (first output); then inherit | `0` = 5 V, `1` = nominal 24 V/+UB_Logic |
| `N6_INPUT_PULLUP` | Inherit motor; motor default `0` | `0` = pull-down, `1` = pull-up |

The position-output component defaults to **5 V** for the digital output.
Set `N6_IO_24V=1` to select nominal 24 V/+UB_Logic instead. These settings
configure the logic I/O, not the motor power supply (for example 48 V).
The motor component's existing I/O default is unchanged; the position-output
component queues its own selection afterwards.

```text
MACROS='FULL_STEPS=100,OUTPUT=1,ARM=1,N6_IO_24V=0,N6_INPUT_PULLUP=0'
MACROS='FULL_STEPS=100,OUTPUT=1,ARM=1,N6_IO_24V=1,N6_INPUT_PULLUP=0'
```

`323A:01` is a shared selector: changing output voltage also changes the
digital input thresholds. `323A:02` selects the shared input bias. These
settings apply to the drive, not just the selected output. Later output
components inherit the first output's voltage; conflicting explicit choices
are rejected before any writes. Input bias inherits the motor selection
(default pull-down) unless explicitly overridden.

Supported intervals are `10^n * d`, where `n=0..6` and
`d` is 1, 2, 4, 8, 16, 32 or 64. All other values are rejected. The component
selects the canonical full-step unit `10^n` and the matching direct-position
divider. For example 100 uses `60A8=0x02AC0000`, `3252:02=0x0910` on output 1;
200 uses the same unit and divider 2. Multiple outputs may share a slave only
when their canonical unit exponent agrees. This prevents later configuration
of one output from silently changing the others' periods. Apply all motor
settings first; reapplying the motor after PositionOutput is rejected.

Examples of the existing interval selection:

| `FULL_STEPS` | `60A8` position unit | Divider | Output-1 route |
| --- | --- | --- | --- |
| 1 | `0x00AC0000` | 1 | `0x0910` |
| 10 | `0x01AC0000` | 1 | `0x0910` |
| 40 | `0x01AC0000` | 4 | `0x0B10` |
| 100 | `0x02AC0000` | 1 | `0x0910` |

These choices need no new ecmccomp implementation. If combining outputs,
remember that the shared-unit rule still applies: 10 and 40 can coexist;
1 and 40 cannot use their canonical units together on the same drive.

The component checks per-master/slave metadata published by N6_OPT and the
N6 motor component. It disables the sensorless interface (`60E6:01=0`) and
does not use `3203` or `205C`. Enabling nominal sensorless resolution caused
sensor fault 7305 during commissioning and is not part of this feature.

The selected gate is changed through `Cfg.WriteEcEntryEcPath` with a bit
index on the existing U32 output word. Other gates and the brake bit are
preserved. ecmccfg supplies masked `PosOut01-Ena` through `PosOut03-Ena` PVs
and prevents its output records from overwriting the gates at IOC startup.
Direct writes to the whole `BO01-Arr` word still intentionally replace every
bit; use the individual gate PVs when changing one output.

The direct output source is limited to 500 Hz. Pulse width, starting phase,
reverse motion and counter rollover require application commissioning.
Changing the interval is a startup configuration operation, not a live scan
parameter. No settings are saved to drive flash by this component.

The N6 manual warns that raw 6063 is invalid with zero interface resolution.
Bench measurements and an operating axis demonstrated the open-loop counter
in this firmware despite that warning. Do not infer support for other modes
or firmware without commissioning them.

## Hardware options and axis homing

The additional N6 PDOs belong to **ecmccfg**, not the component macro list:

```text
HW_DESC=N6-1-1-1-S_OPT,OPT='RAW_POS=1,HOMING=1,CAPTURE=1,ANALOG_IN=1'
```

| Hardware option | Purpose |
| --- | --- |
| `RAW_POS` | Fine `6063` feedback as `positionActual01`; required by this component |
| `HOMING` | Method/offset, drive homing speeds/acceleration and a dedicated bit-4 trigger alias |
| `CAPTURE` | `3241:01–0C` capture readbacks; arming remains an SDO operation |
| `ANALOG_IN` | Both `3320:01–02` analog values in drive-defined units |

Pass these in `addSlave`'s `OPT`, not in `applyComponent`'s `MACROS`.
Their records, panels and PDO allocation are supplied by ecmccfg; the
component continues to use the same N6 type and per-slave raw-mapping flag.
No new capture/analog/homing motor SDO component is required.

The ecmccfg axis example uses sequence 26 (drive-triggered homing), with
`autoMode` set to normal mode 9 / home mode 6. It links the trigger to
`driveCmdExe01.0` and ready to `driveStatus01.12`. The dedicated B1 alias
prevents the DS402 axis's whole-word writes from clearing the trigger.
Drive method 35 references scaled `6064`; sequence 26 separately references
the ecmc encoder object. Raw `6063` remains unchanged. The post-home stage
uses a target equal to the home position to acknowledge CSV restoration
without an extra move. Start through the normal axis Home command; this is
not automatic IOC-startup homing.

Keep the output gate disarmed during referencing and re-arm after verifying
the result; the component does not coordinate that gate with homing.
On the tested 100-step setup, the first edge was reported at 100 full steps
after a fresh start, then at 50 steps after method-35 homing, followed by
100-step edge spacing (50, 150, 250, ...). This was repeatable. Here an edge
is a state transition, not a full high/low cycle. Homing after startup is a
proposed way to establish a consistent first edge; other conditions and
homing completion/error handling still require commissioning.

The separate 2 kHz software-PWM trial is also in ecmccfg. It is time-based,
not counter-synchronous, and does not change this component's documented
500 Hz position-output limit. PWM frequency/duty remain SDO-only.

See the ecmccfg Hugo N6 OPT guide and
`examples/PSI/lab_setup/N6/README_position_output_100_steps.md` for the
current complete configuration and commissioning notes.

## Coexistence with software PWM

`Drive-Generic-PWMOutput` can configure other physical outputs on the same
drive. The components reject competing claims on the same output and
conflicting shared I/O voltage/input-bias settings. Apply all motor settings
first. See [N6 software PWM output](N6_pwm_output.md).
