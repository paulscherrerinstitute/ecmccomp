#==============================================================================
# EL2521_SDOS_STEP_DIR.cmd
#-d /**
#-d   \brief SDOS for EL2521  step direction drive
#-d   \details Parametrization of EL2521
#-d   \author Anders Sandström
#-d   \file
#-d 
#-d   CH1=0x8010  (not consistent with EL2522 where ch1 is on 0x8000)
#-d */

epicsEnvSet(SDO_ADDRESS,"0x8010")
< ${ecmccomp_DIR}EL252X_SDOS_STEP_DIR.cmd
