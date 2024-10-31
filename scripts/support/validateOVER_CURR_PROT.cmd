#==============================================================================
# validateOVER_CURR_PROT.cmd
#-d /**
#-d   \brief Common script for validation of over current protection terminals like EL9227-5500
#-d   \author Anders Sandström
#-d   \file

#-===== Validate HW_DESC matches component ===
ecmcEpicsEnvSetCalcTernary(DIE,"'OVER_CURR_PROT' in '${SLAVE_TYPE}'","#-", "")
${DIE}ecmcExit Error: Component and slave do not matching

#-===== Check max setting ===
ecmcEpicsEnvSetCalcTernary(DIE,"$(PROT_I_MAX_MA)>$(I_MAX_MA=0)","#-", "")
${DIE}ecmcExit Error: Current setting too high. 

#-===== Check min setting ===
ecmcEpicsEnvSetCalcTernary(DIE,"$(I_MAX_MA=0)>0","#-", "")
${DIE}ecmcExit Error: Current setting too low (0 or below)
