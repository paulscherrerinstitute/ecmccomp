#-d /**
#-d   \brief hardware script for motor Beckhoff AM8112-XXX0
#-d   \details Parametrization of motor Beckhoff AM8112-XXX0
#-d   \author Anders Sandström
#-d   \file
#-d   \note For important parameters see TwinCAT CoE startup list for the 
#-d   \note motor terminal configuration.
#-d */

#- Define specifc type since the drives are taylored. So special variable units, same as drive..
#- Component TYPE []
epicsEnvSet(COMP_TYPE,EL72XX_RES_SERVO)

#- Max Voltage [mV]
epicsEnvSet(MOT_U_MAX_MV,48000)

#- Max Current [mA]
epicsEnvSet(MOT_I_MAX_MA,16500)

#- Nominal Current [mA]
epicsEnvSet(MOT_I_NOM_MA,4500)

#- Pole pairs []
epicsEnvSet(MOT_POLE_PAIRS,3)

#- Torque Constant [mNm/A]
epicsEnvSet(MOT_TRQ_CONST_MNM_P_A,81)

#- Phase inductance [0.1mH]
epicsEnvSet(MOT_L_COIL,8)

#- Commutation offset [deg]
epicsEnvSet(MOT_COM_OFFSET_DEG,270)

#- Thermal time constant [0.1s]
epicsEnvSet(MOT_THERM_CONST,491)

#- Motor Speed limitation [rpm]
epicsEnvSet(MOT_VELO_LIM,5100)

#- Current loop proportianal gain [0.1V/A]
epicsEnvSet(MOT_CURR_KP,94)

#- Current loop integral time [0.1ms]
epicsEnvSet(MOT_CURR_TI,2)

#- Velocity loop proportianal gain [mA/(rad/s)]
epicsEnvSet(MOT_VELO_KP,53)

#- Velocity loop integral time [0.1ms]
epicsEnvSet(MOT_VELO_TI,150)

#- ###### Differs with brake:
#- Rotor moment of inertia [gcm^2]
epicsEnvSet(MOT_ROT_INERTIA_GCM2,75)

#- Brake Application delay
epicsEnvSet(MOT_BRK_APP_DLY,20)

#- Brake Release delay
epicsEnvSet(MOT_BRK_REL_DLY,8)
