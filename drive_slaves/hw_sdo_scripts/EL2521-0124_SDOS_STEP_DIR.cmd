#==============================================================================
# EL2521-0124_SDOS_STEP_DIR.cmd
#-d /**
#-d   \brief SDOS for EL2521  step direction drive
#-d   \details Parametrization of EL2521
#-d   \author Anders Sandström
#-d   \file
#-d 
#-d Note: 
#-d    EL2521 CH1 0x8010
#-d    EL2521-0124 CH1 0x8000
#-d    EL2522 CH1 0x8000
#-d    EL2522 CH2 0x8010
#-d
#-d   CH1=0x8000
#-d */

epicsEnvSet(SDO_ADDRESS,"0x8000")

#- Call genric cfg
ecmcFileExist("${ecmccomp_DIR}EL252X_SDOS_STEP_DIR.cmd",1,1)
< ${ecmccomp_DIR}EL252X_SDOS_STEP_DIR.cmd
