#-d /**
#-d   \brief hardware script for motor Beckhoff AM8122-XFX0
#-d   \details Parametrization of motor Beckhoff AM8122-XFX0
#-d   \author Anders Sandström
#-d   \file
#-d   \note For important parameters see TwinCAT CoE startup list for the 
#-d   \note motor terminal configuration.
#-d */

#- Define specifc type since the drives are taylored. So special variable units, same as drive..
#- Component TYPE []
epicsEnvSet(COMP_TYPE,EL72XX_RES_SERVO)

#- Max Voltage [mV] x
epicsEnvSet(MOT_U_MAX_MV,48000) 

#- Max Current [mA] x
epicsEnvSet(MOT_I_MAX_MA,48000)

#- Nominal Current [mA] x
epicsEnvSet(MOT_I_NOM_MA,8000)

#- Pole pairs [] x
epicsEnvSet(MOT_POLE_PAIRS,3)

#- Torque Constant [mNm/A] x
epicsEnvSet(MOT_TRQ_CONST_MNM_P_A,100)

#- Phase inductance [0.1mH] x
epicsEnvSet(MOT_L_COIL,7)

#- Commutation offset [deg] x
epicsEnvSet(MOT_COM_OFFSET_DEG,270)

#- Thermal time constant [0.1s] x
epicsEnvSet(MOT_THERM_CONST,1020)

#- Motor Speed limitation [rpm] x
epicsEnvSet(MOT_VELO_LIM,5530)

#- Current loop proportianal gain [0.1V/A] x
epicsEnvSet(MOT_CURR_KP,83)

#- Current loop integral time [0.1ms] x
epicsEnvSet(MOT_CURR_TI,5)

#- Velocity loop proportianal gain [mA/(rad/s)] x
epicsEnvSet(MOT_VELO_KP,224)

#- Velocity loop integral time [0.1ms] x
epicsEnvSet(MOT_VELO_TI,150) 

#- ###### Differs with brake:
#- Rotor moment of inertia [gcm^2] x
epicsEnvSet(MOT_ROT_INERTIA_GCM2,253)

#- Brake Application delay
epicsEnvSet(MOT_BRK_APP_DLY,0)

#- Brake Release delay
epicsEnvSet(MOT_BRK_REL_DLY,0)
