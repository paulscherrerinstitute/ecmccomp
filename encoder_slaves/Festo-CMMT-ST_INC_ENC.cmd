#-d /**
#-d   \brief SDOS for Incremental encoder interface of Festo CMMT-ST  
#-d   \details Parametrization of Festo CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d              INV_DIR      : Invert motor direction (0 = not invert (default), 1 = invert dir)
#-d              ST_ENC_RES   : Singleturn encoder resolution (default 500 counts per rev)
#-d */

#- Type
epicsEnvSet(SLAVE_TYPE,"INC_ENC")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"Festo-CMMT-ST_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"INV_DIR")
