#==============================================================================
# EL2522_STEP_DIR.cmd
#-d /**
#-d   \brief SDOS for EL2522 step direction drive (encoder simulation terminal)
#-d   \details Parametrization of EL2522
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d          STEP_DIR    (general Step direction cfg):
#-d              XX     : XX
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"STEP_DIR")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL25XX_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"2")
