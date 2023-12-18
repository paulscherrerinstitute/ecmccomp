#-d /**
#-d   \brief SDOS for EL72XX drive RES
#-d   \details Parametrization of EL72XX
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"EL72XX_RES_SERVO")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL72XX_RES_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"I_MAX_MA,U_NOM_MV,CURR_KP,CURR_TI,VELO_KP,VELO_TI,BRK_APP_DLY,BRK_REL_DLY")
