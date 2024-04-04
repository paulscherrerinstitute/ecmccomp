#-d /**
#-d   \brief hardware script for Motor-OrientalMotor-PK268MD
#-d   \details Parametrization of motor Oriental Motor PK268MD
#-d   \author
#-d   \file
#-d */

#- Component TYPE []
epicsEnvSet(COMP_TYPE,2PH_STEPPER)

#- Max Current [mA]
epicsEnvSet(MOT_I_MAX_MA,2000)

#- Standby Current [mA] (30% of max)
ecmcEpicsEnvSetCalc(MOT_I_STDBY_MA,"${MOT_I_MAX_MA}*0.3","%d")

#- Max Voltage [mV]
epicsEnvSet(MOT_U_MAX_MV,48000)

#- Motor Voltage at MOT_I_MAX_MA [mV]
epicsEnvSet(MOT_U_MV,2460)

#- Phase resistance [mOhm]
epicsEnvSet(MOT_R_COIL_MOHM,1230)

#- Phase inductance [uH]
epicsEnvSet(MOT_L_COIL_UH,4700)

#- Max Torque [mNm]
epicsEnvSet(MOT_TRQ_MAX_NMM,2300)

#- EMF [mV/(rad/s)], used for EL7041, set to 0 if unknown
epicsEnvSet(MOT_EMF,0)

#- Motor steps []
epicsEnvSet(MOT_STEPS,200)

#- Rotor Inertia [gcm²]
epicsEnvSet(MOT_ROT_INERTIA_GCM2,520)


