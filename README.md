# ecmccomp: Components library for ecmc

This repo contains component configurations for ecmc. A component can be a motor, encoder or a special configuration.
Component configurations/parameters are stored in engineering units in files. Only one file per component is needed.

The applyComponent.cmd applies a component to an EtherCAT slave including:
* Validation that the slave supports the component. For instance a motor component can be applied to a drive-slave but not an encoder-slave.
* Validates that the custom macros are supported by the slave and component combination
* Applies the configuration (including conversion from engineering units to the units needed by the slave)

The same component configuration can therefore be used for different types of EtherCAT slaves.

## Examples

Some examples:
```
...
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd,       "SLAVE_ID=14, HW_DESC=EL5042"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Encoder-RLS-LA11-26bit-BISS-C, CH_ID=1"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Encoder-RLS-LA11-26bit-BISS-C, CH_ID=2"
...
...
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd,       "HW_DESC=EL7031"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Motor-Generic-2Phase-Stepper,  MACROS='I_MAX_MA=1000, I_STDBY_MA=200, U_NOM_MV=24000, R_COIL_MOHM=1230,SPEED_RANGE=2'"
...
...
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd,       "HW_DESC=EL7041-0052"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Motor-Generic-2Phase-Stepper,  MACROS='I_MAX_MA=1500, I_STDBY_MA=1000, U_NOM_MV=48000, R_COIL_MOHM=1230'"
...
...
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd,       "HW_DESC=EL7211-9014_ALL_INPUTS"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Motor-Beckhoff-AM8111-XFX0,    MACROS='I_MAX_MA=1355'"
...
...
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd,       "HW_DESC=EL9227-5500"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Over-Curr-Prot, CH_ID=1,       MACROS='I_MAX_MA=4000'"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Over-Curr-Prot, CH_ID=2,       MACROS='I_MAX_MA=2000'"
...
```

## Apply a component to a slave
```
#- Execute directly after addSlave.cmd then only COMP macro is needed:
iocshLoad addSlave.cmd, "HW_DESC=EL7037"
iocshLoad applyComponent.cmd "COMP=Motor-OrientalMotor-PK267JB-Parallel"

#- Execute for a custom slave id then COMP_S_ID is needed:
iocshLoad applyComponent.cmd "COMP_S_ID=12,EC_COMP_TYPE=EL7037,COMP=Motor-OrientalMotor-PK267JB-Parallel"

#- CH and custom macros to the cfg can be added
iocshLoad applyComponent.cmd ",EC_COMP_TYPE=EL7037,COMP=Motor-OrientalMotor-PK267JB-Parallel,CH_ID=1,MACROS='I_MAX_MA=500,I_STDBY_MA=100'"
```

## Component types

A component sets `COMP_TYPE`; the matching slave definition declares its
supported macros, channels and SDO script. Current types include:

| Group | Types |
| --- | --- |
| Motors/drives | `2PH_STEPPER`, `STEP_DIR`, `BLDC`, `EL72XX_OCT_SERVO`, `EL72XX_RES_SERVO`, `SMARACT_PIEZO` |
| Encoders | `INC_ENC`, `OPENLOOP_ENC`, `SSI_ENC`, `BISS_C_ENC` |
| Drive outputs | `POSITION_OUTPUT`, `PWM_OUTPUT` (currently N6) |
| Other | `CTRL_PARAMS`, `MULTI_AI`, `OVER_CURR_PROT`, `GENERIC` |

Examples and component declarations are in `motors/`, `encoders/`,
`drive_slaves/`, `misc/` and `ai/`. Slave-specific support is in the
corresponding `*_slaves/` directories.

## Slave configurations
Each type of ethercat slave has:
* A definition file defining what is supported. For instance, the EL7037 slave supports the component types "2PH_STEPPER" and "INC_ENC". Also, max current and voltage are listed here.
* A file containing conversions from the engineering unit parameter in the configuration file to actual values sent to hardware (SDOS)

## 2PH_STEPPER

The following variables needs to defined for a 2 phase stepper
Example:
```
#-d /**
#-d   \brief hardware script for Motor-OrientalMotor-PK267JB-Parallel
#-d   \details Parametrization of motor Oriental Motor PK267JB
#-d   \author Anders Sanddtröm
#-d   \file
#-d   \note Max current= 2 A
#-d   \note Max voltage= 48 V
#-d   \note Inductance per phase =3.54mH
#-d   \note Resistance = 2.4 Ohm
#-d */

#- Max Current [mA]
epicsEnvSet(MOT_I_MAX_MA,2000)

#- Nominal Current [mA]
epicsEnvSet(MOT_I_RUN_MA,${MOT_I_MAX_MA})

#- Standby Current [mA] (30% of max)
ecmcEpicsEnvSetCalc(MOT_I_STDBY_MA,"${MOT_I_RUN_MA}*0.3","%d")

#- Max Voltage [mV]
epicsEnvSet(MOT_U_MAX_MV,48000)

#- Motor Voltage at MOT_I_MAX_MA [mV]
epicsEnvSet(MOT_U_MV,4800)

#- Phase resistance [mOhm]
epicsEnvSet(MOT_R_COIL_MOHM,2400)

#- Phase inductance [uH]
epicsEnvSet(MOT_L_COIL_UH,4540)

#- Max Torque [Nmm]
epicsEnvSet(MOT_TRQ_MAX_NMM,1700)

#- Motor steps []
epicsEnvSet(MOT_STEPS,200)

#- Component TYPE []
epicsEnvSet(COMP_TYPE,2PH_STEPPER)

```
### BISS_C_ENC

See `encoders/Encoder-Generic-BISS-C.cmd` and `encoder_slaves/` for
component definitions and supported slave combinations.

## Slave types

## 2PH_STEPPER

```
#-d /**
#-d   \brief SDOS for EL7037 drive
#-d   \details Parametrization of EL7037
#-d   \author Anders Sanddtröm
#-d   \file
#-d   \note Max current= 1.5 A
#-d   \note Max voltage= 24 V
#-d */

#- Currents
epicsEnvSet(DRV_I_MAX_MA,1500)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,24000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL70X7_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")

#- Drive type
epicsEnvSet(SLAVE_TYPE,2PH_STEPPER)
```

### BISS_C_ENC

See `encoders/Encoder-Generic-BISS-C.cmd` and `encoder_slaves/` for
component definitions and supported slave combinations.


## Apply to a specific slave

Use `COMP_S_ID` to select a previously added slave and `EC_COMP_TYPE` for
its component-support type. `HW_DESC` belongs to ecmccfg's `addSlave`, not
to `applyComponent`:

```text
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP_S_ID=12,EC_COMP_TYPE=EL7037,COMP=Motor-OrientalMotor-PK267JB-Parallel,MACROS='I_MAX_MA=1000'"
```

## Validation

When a component is applied to a slave a validation procedure is executed.

The following validations are made for all components:
* Check that the CH_ID is supported by the slave drive
* Check that the user macros are supported by the slave type

### Validation of 2PH_STEPPER components
* Check that the defined current is NOT higher than the allowed by both the motor component and the slave drive.
* Check that the defined voltage is NOT higher than the allowed by both the motor component and the slave drive.
* Check that the component type matches the slave type (`2PH_STEPPER`).

The generic stepper validator first limits declared motor capabilities to
the slave capabilities, then rejects requested current/voltage settings
that exceed the resulting limits. Do not rely on silently clamping an
out-of-range request. Additional checks are component/slave-specific; the
N6 output components also check shared resources and startup order.

## Nanotec N6 outputs

Install matching versions of ecmccfg and ecmccomp. ecmccfg supplies the N6
PDO mappings, records, panels and axis examples; ecmccomp supplies reusable
SDO configuration. Apply the hardware first, the motor second, then output
components before applying EtherCAT configuration.

### Position-related output

```text
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd "HW_DESC=N6-1-1-1-S_OPT,OPT='RAW_POS=1,HOMING=1'"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Motor-Generic-2Phase-Stepper,CH_ID=1,MACROS='I_MAX_MA=400,I_STDBY_MA=100,STEPS=200,INV_DIR=0'"
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Drive-Generic-PositionOutput,CH_ID=1,MACROS='FULL_STEPS=100,OUTPUT=1,ARM=0,N6_IO_24V=0'"
```

This component requires `RAW_POS=1` and `INV_DIR=0`. Fine `6063` feedback
uses `positionActual01`; scaled `6064` uses `positionActualScaled01` for the
drive-side output. Supported intervals are `10^n` times `1,2,4,8,16,32,64`,
with `n=0..6`; this includes 1, 10, 40 and 100 full steps. Outputs on one
drive must share the canonical position unit. The documented direct
position-output limit is 500 Hz.

See [N6 position output](docs/N6_position_output.md) for the full macro list,
shared-unit rules, first-edge observations and firmware-specific feedback.

### Software PWM output

As an alternative to PositionOutput on output 1, after the same hardware
and motor setup:

```text
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "COMP=Drive-Generic-PWMOutput,CH_ID=1,MACROS='FREQUENCY_HZ=2000,DUTY_PERCENT=50,OUTPUT=1,PWM_ID=0,ARM=0,N6_IO_24V=0'"
```

PWM is time-based, not position-synchronous. Frequency accepts plain integer
50..2000 Hz and duty accepts 0..100 percent. Physical outputs 1..3 and PWM
generators 0/1 are selectable. Outputs sharing a generator must use the
same frequency/duty. Frequency/duty use startup SDOs; no live SDO PVs or
extra PDOs are supplied for those settings.

See [N6 PWM output](docs/N6_pwm_output.md) for parameters, routing, the
bench-reported configuration and the status of older lab snippets.

### Shared settings and responsibilities

Both output components default to **5 V** for the first output and
`ARM=0`. Later outputs inherit the selected voltage. `N6_IO_24V=1` selects
nominal 24 V/+UB_Logic; this also changes digital input thresholds, not the
motor supply. `N6_INPUT_PULLUP` inherits the motor setting unless overridden.
Use ecmccfg's masked `PosOut01-Ena` through `PosOut03-Ena` PVs to arm/disarm.

PositionOutput and PWMOutput can coexist on different outputs, but reject
competing claims on the same output or conflicting shared electrical
settings. Configure all motor settings first; reapplying the motor after
an output component is rejected. These components save nothing to flash.

Hardware options `RAW_POS`, `HOMING`, `CAPTURE` and `ANALOG_IN` belong in
`addSlave`'s `OPT`, not a component's `MACROS`. Homing sequence 26 and its
automatic mode switching belong in the axis YAML. See the ecmccfg Hugo N6
OPT guide and `examples/PSI/lab_setup/N6/` for runnable configurations.

## Extending and installing components

The generic loader is `scripts/applyComponent.cmd`. It combines a component
file with `<EC_COMP_TYPE>_<COMP_TYPE>.cmd`, validates the requested macros,
runs the matching `validate<COMP_TYPE>.cmd`, applies the slave SDO script,
and cleans up temporary macros. Follow an existing matching component when
adding a new type. Keep hardware PDO definitions and panels in ecmccfg.

`GNUmakefile` installs the component and support scripts through directory
wildcards. Build/install the module with the site's normal EPICS module
tools after adding scripts; updating ecmccfg alone does not install a new
ecmccomp component. The N6 cross-repository command-capture tests are in
ecmccfg under `tests/integration/`; they do not access hardware.
