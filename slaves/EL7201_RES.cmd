#-d /**
#-d   \brief SDOS for EL7201 drive RES
#-d   \details Parametrization of EL7201 Resolver version
#-d   \author Anders Sanddtröm
#-d   \file
#-d   \note Max current= 5.7 A
#-d   \note Max voltage= 48 V
#-d */

#- Same as OCT version except different SDOS script
< ${ecmccomp_DIR}EL7201_OCT.cmd

#- Drive type
epicsEnvSet(SLAVE_TYPE,EL72XX_RES_SERVO)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL72XX_RES_SDOS")
