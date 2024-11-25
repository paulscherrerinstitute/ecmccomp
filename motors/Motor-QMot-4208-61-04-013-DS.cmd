#-d /**
#-d   \brief hardware script for motor Beckhoff AM8111-XXX0
#-d   \details Parametrization of motor Beckhoff AM8111-XXX0
#-d   \author Anders Sandström
#-d   \file
#-d   \note For important parameters see TwinCAT CoE startup list for the 
#-d   \note motor terminal configuration.
#-d */

#- Define specifc type since the drives are taylored. So special variable units, same as drive..
#- Component TYPE []
epicsEnvSet(COMP_TYPE,BLDC)

#- Max Voltage [mV]
epicsEnvSet(MOT_U_MAX_MV,48000)

#- Max Current [mA]
epicsEnvSet(MOT_I_MAX_MA,10600)

#- Nominal Current [mA]
epicsEnvSet(MOT_I_NOM_MA,3470)

#- Pole pairs []
epicsEnvSet(MOT_POLE_PAIRS,4)

#- Torque Constant [mNm/A]  36mNm/A
epicsEnvSet(MOT_TRQ_CONST_MNM_P_A,36)

#- Phase inductance [mH]
epicsEnvSet(MOT_L_COIL,1.2)

#- Thermal time constant [s]
epicsEnvSet(MOT_THERM_CONST,1620)

#- Motor Speed limitation [rpm]
epicsEnvSet(MOT_VELO_LIM,4000)

#- Current loop proportianal gain [0.1V/A]
epicsEnvSet(MOT_CURR_KP,10)

#- Current loop integral time [0.1ms]
epicsEnvSet(MOT_CURR_TI,10)

#- Velocity loop proportianal gain [mA/(rad/s)]
epicsEnvSet(MOT_VELO_KP,20)

#- Velocity loop integral time [0.1ms]
epicsEnvSet(MOT_VELO_TI,50)
