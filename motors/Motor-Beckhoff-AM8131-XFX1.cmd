#-d /**
#-d   \brief hardware script for motor Beckhoff AM8131-XFX1
#-d   \details Parametrization of motor Beckhoff AM8131-XFX1
#-d   \author Anders Sandström
#-d   \file
#-d   \note For important parameters see TwinCAT CoE startup list for the 
#-d   \note motor terminal configuration.
#-d */

#- Define specifc type since the drives are taylored. So special variable units, same as drive..
#- Component TYPE []
epicsEnvSet(COMP_TYPE,EL72XX_OCT_SERVO)

#- Max Voltage [mV]
epicsEnvSet(MOT_U_MAX_MV,48000)

#- Max Current [mA]
epicsEnvSet(MOT_I_MAX_MA,27800)

#- Nominal Current [mA]
epicsEnvSet(MOT_I_NOM_MA,4950)

#- Pole pairs []
epicsEnvSet(MOT_POLE_PAIRS,4)

#- Torque Constant [mNm/A]
epicsEnvSet(MOT_TRQ_CONST_MNM_P_A,270)

#- Phase inductance [0.1mH]
epicsEnvSet(MOT_L_COIL,53)

#- Commutation offset [deg]
epicsEnvSet(MOT_COM_OFFSET_DEG,270)

#- Thermal time constant [0.1s]
epicsEnvSet(MOT_THERM_CONST,721)

#- Motor Speed limitation [rpm]
epicsEnvSet(MOT_VELO_LIM,1233)

#- Current loop proportianal gain [0.1V/A]
epicsEnvSet(MOT_CURR_KP,628)

#- Current loop integral time [0.1ms]
epicsEnvSet(MOT_CURR_TI,5)

#- Velocity loop proportianal gain [mA/(rad/s)]
epicsEnvSet(MOT_VELO_KP,151)

#- Velocity loop integral time [0.1ms]
epicsEnvSet(MOT_VELO_TI,150)

#- ###### Differs with brake:
#- Rotor moment of inertia [gcm^2]
epicsEnvSet(MOT_ROT_INERTIA_GCM2,541)

#- Brake Application delay
epicsEnvSet(MOT_BRK_APP_DLY,25)

#- Brake Release delay
epicsEnvSet(MOT_BRK_REL_DLY,8)
