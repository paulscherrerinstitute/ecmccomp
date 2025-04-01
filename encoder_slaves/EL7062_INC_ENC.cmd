#-d /**
#-d   \brief SDOS for Incremental encoder interface of EL7411
#-d   \details Parametrization of EL7411
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d              INV_DIR      : Invert motor direction (0 = not invert (default), 1 = invert dir)
#-d              ST_ENC_RES   : Singleturn encoder resolution (default 500 counts per rev)
#-d              TYPE         : Encoder type:
#-d                               0: disabled
#-d                               1: rs422 (default)
#-d                               2: TTL single ended
#-d                               6: TTL single ended, filters disabled 
#-d                               7: Open collector
#-d */

#- Type
epicsEnvSet(SLAVE_TYPE,"INC_ENC")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL7062_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"2")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"INV_DIR,ST_ENC_RES,TYPE")
