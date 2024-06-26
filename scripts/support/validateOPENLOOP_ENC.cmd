#==============================================================================
# validateOPENLOOP.cmd
#-d /**
#-d   \brief Common script for validation of open loop encoders
#-d   \author Anders Sandström
#-d   \file

#-===== Validate HW_DESC matches component ===
ecmcEpicsEnvSetCalcTernary(DIE,"'OPENLOOP_ENC' in '${SLAVE_TYPE}'","#-", "")
${DIE}ecmcExit Error: Component and slave do not matching
