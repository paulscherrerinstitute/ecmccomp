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

#- Component TYPE []
epicsEnvSet(COMP_TYPE,2PH_STEPPER)

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

#- EMF (EL7041) set to 0 if unknown
epicsEnvSet(MOT_EMF,0)

#- Motor steps []
epicsEnvSet(MOT_STEPS,200)
