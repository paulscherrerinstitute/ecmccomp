#-d /**
#-d   \brief SDOS for SmaraAct MCS2
#-d   \details Parametrization of EL7047
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 5 A
#-d   \note Max voltage= 48 V
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"MCS2_DRIVE")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"HOME_VELO,HOME_ACC,HOME_METHOD_ID")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"MCS2_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"3")
