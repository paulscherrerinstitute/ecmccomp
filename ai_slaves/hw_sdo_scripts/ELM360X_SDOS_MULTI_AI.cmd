#==============================================================================
# ELM360X_SDOS.cmd
#-d /**
#-d   \brief SDOS for ELM360X multi analog input
#-d   \details Parametrization of EL5042
#-d   \author Anders Sandström
#-d   \file
#-d */  

#- Calculate SDO adress based on CH (0x8008 for CH1, 0x8018 for CH2,..)
ecmcEpicsEnvSetCalc(CH_ID_LOCAL,"${CH_ID=1}-1")

#- Execute file for defined range
ecmcFileExist(${ecmccomp_DIR}${SLAVE_SCRIPT}_${SLAVE_TYPE}_${RANGE}-chX.cmd,1,1)
< ${ecmccomp_DIR}${SLAVE_SCRIPT}_${SLAVE_TYPE}_${RANGE}-chX.cmd
#- Cleanup
epicsEnvUnset(CH_ID_LOCAL)
