#-d /**
#-d   \brief hardware script for Festo-EMMS-ST-42-S-SE-G2
#-d   \details Parametrization of motor Festo-EMMS-ST-42-S-SE-G2
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 1.8A (series)
#-d   \note Max voltage= 48V
#-d   \note Inductance per phase = 3.3mH
#-d   \note Resistance = 1.75 Ohm / "half" phase => 4.8 Ohm for series
#-d */

#- Component TYPE []
epicsEnvSet(COMP_TYPE,2PH_STEPPER)

#- Max Current [mA]
epicsEnvSet(MOT_I_MAX_MA,1800)

#- Standby Current [mA] (30% of max)
ecmcEpicsEnvSetCalc(MOT_I_STDBY_MA,"${MOT_I_MAX_MA}*0.3","%d")

#- Max Voltage [mV]
epicsEnvSet(MOT_U_MAX_MV,48000)

#- Motor Voltage at MOT_I_MAX_MA [mV]
epicsEnvSet(MOT_U_MV,3500)

#- Phase resistance [mOhm]
epicsEnvSet(MOT_R_COIL_MOHM,1750)

#- Phase inductance [uH]
epicsEnvSet(MOT_L_COIL_UH,3300)

#- Max Torque [mNm]
epicsEnvSet(MOT_TRQ_MAX_NMM,470)

#- EMF [mV/(rad/s)], used for EL7041, set to 0 if unknown
epicsEnvSet(MOT_EMF,0)

#- Motor steps []
epicsEnvSet(MOT_STEPS,200)

#- Rotor Inertia [gcm²]
epicsEnvSet(MOT_ROT_INERTIA_GCM2,82)
