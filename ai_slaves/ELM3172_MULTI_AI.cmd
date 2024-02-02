#-d /**
#-d   \brief SDOS for ELM3172
#-d   \details Parametrization of ELM3172 multi ai
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d */

#- Type
epicsEnvSet(SLAVE_TYPE,"MULTI_AI")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL317X_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"2")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"RANGE")
