#==============================================================================
# EL7411_BLDC.cmd
#-d /**
#-d   \brief SDOS for EL7411 drive
#-d   \details Parametrization of EL7411
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 5 A
#-d   \note Max voltage= 48 V
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d          BLDC    
#-d              I_MAX_MA     : Run current [mA] (Used to reduce max torque)
#-d              U_NOM_MV     : Supply voltage [mV]
#-d              INV_DIR      : Invert motor direction (0 = not invert (default), 1 = invert dir)
#-d              CURR_KP      : Current controller amplification gain [0.1V/A]
#-d              CURR_TI      : Current controller integration [0.1ms]
#-d              VELO_KP      : Current controller amplification gain
#-d              VELO_TI      : Current controller integration [0.1ms]
#-d              COM_TIME     : Commutation time  [0.1ms]
#-d              COM_TYPE     : Commutation type:
#-d                             1 : FOC with incremental encoder (default)
#-d                             2 : Six step with hall
#-d                             3 : Six step sensor less
#-d                             4 : FOC with incremental encoder and hall
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"BLDC")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"I_MAX_MA,U_NOM_MV,INV_DIR,CURR_TI,CURR_KP,VELO_KP,VELO_TI,COMMUT_TIME,COMMUT_TYPE")

#- Currents
epicsEnvSet(DRV_I_MAX_MA,9000)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL7411_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")
