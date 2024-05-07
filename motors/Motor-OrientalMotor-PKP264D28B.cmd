#-d /**
#-d   \brief hardware script for Motor-OrientalMotor-PKP264D28B
#-d   \details Parametrization of motor Oriental Motor PKP264D28B
#-d   \author
#-d   \file
#

#- Component TYPE []
epicsEnvSet(COMP_TYPE,2PH_STEPPER)

#- Max Current [mA]
epicsEnvSet(MOT_I_MAX_MA,2800)

#- Standby Current [mA] (30% of max)
ecmcEpicsEnvSetCalc(MOT_I_STDBY_MA,"${MOT_I_MAX_MA}*0.3","%d")

#- Max Voltage [mV]
epicsEnvSet(MOT_U_MAX_MV,48000)

#- Motor Voltage at MOT_I_MAX_MA [mV]
epicsEnvSet(MOT_U_MV,920)

#- Phase resistance [mOhm]
epicsEnvSet(MOT_R_COIL_MOHM,330)

#- Phase inductance [uH]
epicsEnvSet(MOT_L_COIL_UH,800)

#- Max Torque [mNm]
epicsEnvSet(MOT_TRQ_MAX_NMM,2700)

#- Motor steps []
epicsEnvSet(MOT_STEPS,200)

#- Rotor Inertia [gcm²]
epicsEnvSet(MOT_ROT_INERTIA_GCM2,120)
