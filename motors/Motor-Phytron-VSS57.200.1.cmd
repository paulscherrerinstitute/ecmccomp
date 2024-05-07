#-d /**
#-d   \brief hardware script for Motor-Phytron-VSS57.200.1
#-d   \details Parametrization of motor Phytron Motor VSS57.200.1
#-d   \author
#-d   \file
#-d */

#- Component TYPE []
epicsEnvSet(COMP_TYPE,2PH_STEPPER)

#- Max Current [mA]
epicsEnvSet(MOT_I_MAX_MA,1200)

#- Standby Current [mA] (30% of max)
ecmcEpicsEnvSetCalc(MOT_I_STDBY_MA,"${MOT_I_MAX_MA}*0.3","%d")

#- Max Voltage [mV]
epicsEnvSet(MOT_U_MAX_MV,48000)

#- Motor Voltage at MOT_I_MAX_MA [mV]
epicsEnvSet(MOT_U_MV,2460)

#- Phase resistance [mOhm]
epicsEnvSet(MOT_R_COIL_MOHM,3900)

#- Phase inductance [uH]
epicsEnvSet(MOT_L_COIL_UH,11600)

#- Max Torque [mNm]
epicsEnvSet(MOT_TRQ_MAX_NMM,840)

#- EMF [mV/(rad/s)], used for EL7041, set to 0 if unknown
epicsEnvSet(MOT_EMF,0)

#- Motor steps []
epicsEnvSet(MOT_STEPS,200)

#- Rotor Inertia [gcm²]
epicsEnvSet(MOT_ROT_INERTIA_GCM2,240)


