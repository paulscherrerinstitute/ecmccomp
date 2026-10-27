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
configuration; the component rejects an inverted motor setting.

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
