#-d /**
#-d   \brief SDOS for ELM3604
#-d   \details Parametrization of ELM3604 multi ai
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d */

#- Type
epicsEnvSet(SLAVE_TYPE,"MULTI_AI")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"ELM360X_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"4")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"RANGE")
