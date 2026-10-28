# N6 software PWM output

`Drive-Generic-PWMOutput` packages the SDO configuration of the N6 PWM
bench trial. Use it after `N6-1-1-1-S_OPT` and the motor component, before
applying EtherCAT configuration. PWM is a time-based carrier, not a
position-synchronous pulse generator. Frequency and duty are SDO-only;
this component does not add cyclic PDO or EPICS SDO controls for them.

```text
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd "HW_DESC=N6-1-1-1-S_OPT"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Motor-Generic-2Phase-Stepper,MACROS='I_MAX_MA=400,I_STDBY_MA=100,STEPS=200'"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Drive-Generic-PWMOutput,CH_ID=1,MACROS='FREQUENCY_HZ=2000,DUTY_PERCENT=50,OUTPUT=1,PWM_ID=0,ARM=0,N6_IO_24V=0'"
```

| Macro | Default | Meaning |
| --- | --- | --- |
| `FREQUENCY_HZ` | `2000` | Plain integer 50..2000 Hz |
| `DUTY_PERCENT` | `50` | Plain integer 0..100 percent |
| `OUTPUT` | `1` | Physical digital output 1..3 |
| `PWM_ID` | `0` | Shared PWM generator 0 or 1 |
| `ARM` | `0` | Initial gate: 0 disabled, 1 enabled |
| `N6_IO_24V` | `0` for the first output; then inherit | Shared I/O: 0=5 V, 1=24 V/+UB_Logic |
| `N6_INPUT_PULLUP` | Inherit motor, normally `0` | Shared bias: 0=pull-down, 1=pull-up |

The validator accepts plain integer notation, not expressions, fractions or
scientific notation. It checks type/channel, mapping and motor prerequisites,
shared settings and output ownership before any gate or SDO write. Failure
of a numeric validation expression leaves its branch rejecting the request.
Motor direction inversion does not affect this time-based output.

Generator 0 uses `3260` and routing source `0x12`; generator 1 uses `3261`
and source `0x13`. Physical output n uses routing subindex n+1 and gate bit
n+15 in the existing `60FE:01` word. For the default, `3252:02=0x1210`,
`3260:01=2000` and `3260:02=50`. The component disarms the selected gate,
queues duty 0, frequency and routing, then the requested duty. Finally it
sets only the selected gate to ARM, preserving the brake and other gates.
Duty 0 and 100 select constant endpoints, not a switching waveform.

Several physical outputs can use the same generator only with identical
frequency and duty. To use different settings, choose different PWM_IDs.
PWM and PositionOutput can coexist on different outputs, but a single
physical output cannot be claimed by both. The first output's shared
voltage/input-bias settings apply to later outputs; conflicting explicit
choices are rejected. Reapplying the motor after an output component is
rejected. Restart with a new configuration to change ownership/settings.
No settings are saved to flash.

The motor component retains its existing I/O default; the first output
component selects 5 V unless explicitly overridden. This selector also
changes digital input thresholds, not the motor power supply. N6_OPT
supplies `PosOut01-Ena` through `PosOut03-Ena` and their readbacks. Use
those gates at runtime; avoid replacing the complete BO01-Arr word.

The user reported the original generator-0/output-1, 2 kHz/50%, 5 V trial
working on N6-1-1-1-S / FIR-v2542-B1080909. Exact scope measurements and other
generator/output/duty choices still require commissioning. At 2 kHz/50%,
expect a 500 microsecond period and 250 microseconds high and low. Output 1
is X4 pin 5, referenced to GNDD pin 8. The signal may run with the motor
stationary. The PWM trial uses no motion axis and starts disarmed.

The older EtherCAT manual lists the 2 kHz software-PWM limit and `3260/3261`
objects but omits their routing sources. The newer N6 Modbus TCP manual
v1.2.1 for FIR-v2542 lists sources `0x12/0x13`; the bench report establishes
the tested EtherCAT case. It does not establish support on all variants.
The wider frequency parameter range in the dictionary is not evidence for
physical output above 2 kHz; this component deliberately caps it at 2 kHz.

See ecmccfg's `examples/PSI/lab_setup/N6/startup_software_pwm.cmd`,
`README_software_pwm.md` and Hugo N6 OPT guide for the bench procedure.

## Other N6 lab snippets

- `cfg/position_output_100_steps.cmd` already delegates to
  `Drive-Generic-PositionOutput`.
- `cfg/software_pwm_2khz.cmd` is now a compatibility wrapper around this
  component; new startups should call the component directly.
- `cfg/pulse_per_fullstep.cmd` is the failed `205C/3203` trial retained for
  reproduction, not a supported component.
- `cfg/disable_pulse_source.cmd` is its lab-specific recovery script. It
  clears the whole output word and resets feedback selections; it is not a
  generic output-disable component. Use masked gate PVs for ordinary disarming.
- Axis YAML belongs in ecmccfg: scaling, sequence 26, mode switching and
  motion limits remain axis configuration.
