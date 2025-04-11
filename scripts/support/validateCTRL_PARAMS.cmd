#==============================================================================
# validate2PH_STEPPER.cmd
#-d /**
#-d   \brief Script for validation of 2PH STEPPER
#-d   \author Anders Sandström
#-d   \file

#-===== Validate HW_DESC matches component ===
ecmcEpicsEnvSetCalcTernary(DIE,"'CTRL_PARAMS' in '${SLAVE_TYPE}'","#-", "")
${DIE}ecmcExit Error: Component and slave do not match

