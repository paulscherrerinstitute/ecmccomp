
############################################################
############# Parmetrization of EL72XX OCT for motor AM8111-0F20-0000
#- Motor WITHOUT brake
#-
#- Note: For important parameters see TwinCAT CoE startup list for the 
#-       motor terminal configuration.

#- Define specifc type since the drives are taylored. So special variable units, same as drive..
#- Component TYPE []
epicsEnvSet(COMP_TYPE,EL72XX_OCT_SERVO)

#- Max Voltage [mV]
epicsEnvSet(MOT_U_MAX_MV,48000)

#- Max Current [mA]
epicsEnvSet(MOT_I_MAX_MA,8600)

#- Nominal Current [mA]
epicsEnvSet(MOT_I_NOM_MA,2710)

#- Pole pairs []
epicsEnvSet(MOT_POLE_PAIRS,3)

#- Torque Constant [mNm/A]
epicsEnvSet(MOT_TRQ_CONST,70)

#- Phase inductance [0.1mH]
epicsEnvSet(MOT_L_COIL,15)

#- Commutation offset [deg]
epicsEnvSet(MOT_COM_OFFSET_DEG,270)

#- Thermal time constant [0.1s]
epicsEnvSet(MOT_THERM_CONST,341)

#- Motor Speed limitation [rpm]
epicsEnvSet(MOT_VELO_LIM,5221)

#- Current loop proportianal gain [0.1V/A]
epicsEnvSet(MOT_CURR_KP,178)

#- Current loop integral time [0.1ms]
epicsEnvSet(MOT_CURR_TI,5)

#- Velocity loop proportianal gain [mA/(rad/s)]
epicsEnvSet(MOT_VELO_KP,37)

#- Velocity loop integral time [0.1ms]
epicsEnvSet(MOT_VELO_TI,150)

#- Rotor moment of inertia [gcm^2]
epicsEnvSet(MOT_ROT_INERTIA,29)
