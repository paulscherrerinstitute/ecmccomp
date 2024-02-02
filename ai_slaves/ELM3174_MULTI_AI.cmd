#-d /**
#-d   \brief SDOS for ELM3174
#-d   \details Parametrization of ELM3174 multi ai
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d */

#- Type
epicsEnvSet(SLAVE_TYPE,"MULTI_AI")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL317X_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"4")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"RANGE")
