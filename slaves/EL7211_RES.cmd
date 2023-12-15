#-d /**
#-d   \brief SDOS for EL7211 drive RES
#-d   \details Parametrization of EL7211 Resolver version
#-d   \author Anders Sanddtröm
#-d   \file
#-d   \note Max current= 9 A
#-d   \note Max voltage= 48 V
#-d */

#- Same as OCT version except differnrt SDOS script
< ${ecmccomp_DIR}EL7211_OCT.cmd

#- Drive type
epicsEnvSet(SLAVE_TYPE,EL72XX_RES_SERVO)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL72XX_RES_SDOS")
