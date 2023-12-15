#==============================================================================
# validateBISS_C_ENC.cmd
#-d /**
#-d   \brief Common script for validation of EL5042
#-d   \author Anders Sandström
#-d   \file

#-===== Validate HW_DESC matches component ===
ecmcEpicsEnvSetCalcTernary(DIE,"'BISS_C_ENC' in '${SLAVE_TYPE}'","#-", "")
${DIE}ecmcExit Error: Component and slave do not matching

#- Set enc mode to BISS-C
epicsEnvSet(ENC_MODE,0)
