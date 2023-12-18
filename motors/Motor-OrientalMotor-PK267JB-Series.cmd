#-d /**
#-d   \brief hardware script for Motor-OrientalMotor-PK267JB-Series
#-d   \details Parametrization of motor Oriental Motor PK267JB
#-d   \author Anders Sanddtröm
#-d   \file
#-d   \note Max current= 2 A
#-d   \note Max voltage= 48 V
#-d   \note Inductance per phase = 3.54mH /  "half" phase  => 7.08mH
#-d   \note Resistance = 2.4 Ohm / "half" phase => 4.8 Ohm 
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
epicsEnvSet(MOT_U_MV,4800)

#- Phase resistance [mOhm]
epicsEnvSet(MOT_R_COIL_MOHM,4800)

#- Phase inductance [uH]
epicsEnvSet(MOT_L_COIL_UH,7080)

#- Max Torque [mNm]
epicsEnvSet(MOT_TRQ_MAX_NMM,1700)

#- EMF [mV/(rad/s)], used for EL7041, set to 0 if unknown
epicsEnvSet(MOT_EMF,0)

#- Motor steps []
epicsEnvSet(MOT_STEPS,200)
