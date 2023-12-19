# ecmccomp: Components library for ecmc

This repo contains component configurations for ecmc. A component can be a motor, encoder or a special configuration.
Component configurations/paremeters are stored in engineering units in files. Only one file per component is needed.

The applyComponent.cmd applies a component to a ethercat slave including:
* Validation that the slave supports the componenet. For instance a motor component can be applied to a drive-slave but not a encoder-slave.
* Validates that the custom macros are supported by the slave and component combination
* Applies the configuration

## Apply a component to a slave
```
#- Execute directly after addSlave.cmd then only COMP macro is needed:
iocshLoad addSlave.cmd, "HW_DESC=EL7037"
iocshLoad applyComponent.cmd "COMP=Motor-OrientalMotor-PK267JB-Parallel"

#- Execute for a cutsom slave id then COMP_S_ID is needed:
iocshLoad applyComponent.cmd "COMP_S_ID=12,EC_COMP_TYPE=EL7037,COMP=Motor-OrientalMotor-PK267JB-Parallel"

#- CH and custom macros to the cfg can be added
iocshLoad applyComponent.cmd ",EC_COMP_TYPE=EL7037,COMP=Motor-OrientalMotor-PK267JB-Parallel,CH_ID=1,MACROS='I_MAX_MA=500,I_STDBY_MA=100'"
```

# Component types
The components are sorted into types:

Motors:
* 2PH_STEPPER        : 2 phase stepper motors
* EL72XX_OCT_SERVO   : Beckhoff motors for use with EL72XX OCT drives
* EL72XX_RES_SERVO   : Beckhoff motors for use with EL72XX RES drives

Encoders:
* BISS_C_ENC
* SSI_ENC

# Slave configurations
Each type of ethercat slave has:
* A defintion file defining what is supported. For instance, the EL7037 slave supports the component types "2PH_STEPPER" and "INC_ENC". Also, max current and voltage are listed here.
* A file containg conversions from the engineering unit parameter in the configuration file to actual values sent to hardware (SDOS)

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
## BISS_C_ENC
WIP

# Slave types

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
epicsEnvSet(SLAVE_TYPE,2PH_STEPPER_DRV)
```

## BISS_C_ENC
WIP


# Add a component to a slave

```
${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd, "HW_DESC=EL7037,COMP=Motor-OrientalMotor-PK267JB-Parallel,MACROS='I_RUN_MA=1000'"
```
The HW_DESC must be of a type similar type as the component

# Validation

When a componet is applied to a slave a validation procedure is executed.

The follwoing validations are made for all components:
* Check that the CH_ID is supported by the slave drive
* Check that the user macros are supported by the slave type

##  Validation of 2PH_STEPPER component
* Check that the defined current is NOT higher than the allowed by both the motor component and the slave drive.
* Check that the defined voltage is NOT higher than the allowed by both the motor component and the slave drive.
* Check that the component type matches the slave type (2PH_STEPPER_DRV).

Note: If defined desired current/voltage is higher than either what is supported by the slave drive or by the motor/component then the setting will be automatically reduced without warning(or stopping the IOC).
