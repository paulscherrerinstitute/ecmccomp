#==============================================================================
# EL2522_SDOS_STEP_DIR.cmd
#-d /**
#-d   \brief SDOS for EL2522  step direction drive
#-d   \details Parametrization of EL2522
#-d   \author Anders Sandström
#-d   \file
#-d 
#-d   CH1=0x8000 (32768dec)
#-d   CH2=0x8010 (32768+16 dec)
#-d */

ecmcEpicsEnvSetCalc(SDO_ADDRESS,"32768+(${CH_ID=1}-1)*16","0x%x")
< ${ecmccomp_DIR}EL252X_SDOS_STEP_DIR.cmd
