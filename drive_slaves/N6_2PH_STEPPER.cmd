#==============================================================================
# N6_2PH_STEPPER.cmd
#-d /**
#-d   \brief Nanotec N6-1-1-1-S support for a generic two-phase stepper
#-d   \details Open-loop stepper configuration for the N6 CSV interface
#-d   \file
#-d   \note Rated and peak drive current: 6 Arms
#-d   \note Operating voltage: 12..57.6 VDC
#-d   \param I_MAX_MA       Motor/run current [mA]
#-d   \param I_STDBY_MA     Standby current [mA]
#-d   \param U_NOM_MV       Supply voltage [mV], validated but not written
#-d   \param R_COIL_MOHM    Coil resistance [mOhm], accepted for compatibility
#-d   \param L_COIL_UH      Coil inductance [uH], accepted for compatibility
#-d   \param STEPS          Full steps per revolution (default from motor)
#-d   \param INV_DIR        0=normal, 1=inverted
#-d   \param I2T_MAX_MS     Maximum-current duration [ms], default 100
#-d   \param CURR_RED_DLY_MS Delay before standby-current reduction [ms]
#-d   \param N6_POS_UNIT     0x60A8 position-unit code, default 0x00B50000
#-d   \param N6_VEL_UNIT     0x60A9 velocity-unit code, default 0x00B50300
#-d */

epicsEnvSet(SLAVE_TYPE,"2PH_STEPPER")
epicsEnvSet(SUPP_MACROS,"I_MAX_MA,I_STDBY_MA,U_NOM_MV,R_COIL_MOHM,L_COIL_UH,STEPS,INV_DIR,I2T_MAX_MS,CURR_RED_DLY_MS,N6_POS_UNIT,N6_VEL_UNIT")

epicsEnvSet(DRV_I_MAX_MA,6000)
epicsEnvSet(DRV_U_MAX_MV,57600)

epicsEnvSet(SLAVE_SCRIPT,"N6_SDOS")
epicsEnvSet(SLAVE_CHANNELS,"1")
