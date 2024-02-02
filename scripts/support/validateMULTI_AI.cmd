#==============================================================================
# validateMULTI_AI.cmd
#-d /**
#-d   \brief Common script for validation of MULTI_AI
#-d   \author Anders Sandström
#-d   \file

#-===== Validate HW_DESC matches component ===
ecmcEpicsEnvSetCalcTernary(DIE,"'MULTI_AI' in '${SLAVE_TYPE}'","#-", "")
${DIE}ecmcExit Error: Component and slave do not matching
