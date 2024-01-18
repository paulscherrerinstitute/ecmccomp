#==============================================================================
# validateSMARACT_PIEZO.cmd
#-d /**
#-d   \brief Common script for validation of SmarACT
#-d   \author Anders Sandström
#-d   \file

#-===== Validate HW_DESC matches component ===
ecmcEpicsEnvSetCalcTernary(DIE,"'MCS2_DRIVE' in '${SLAVE_TYPE}'","#-", "")
${DIE}ecmcExit Error: Component and slave do not matching
