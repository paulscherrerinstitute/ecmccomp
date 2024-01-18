#==============================================================================
# validateSMARACT_PIEZO.cmd
#-d /**
#-d   \brief Common script for validation of SmarACT
#-d   \author Anders Sandström
#-d   \file

#-===== Validate HW_DESC matches component ===
ecmcEpicsEnvSetCalcTernary(DIE,"'MCS2_DRIVE' in '${SLAVE_TYPE}'","#-", "")
${DIE}ecmcExit Error: Component and slave do not matching

#- Die HOME_VELO is to high (max 32 bit uint)
ecmcEpicsEnvSetCalcTernary(DIE,"${HOME_VELO=${MOT_HOME_VELO}}*1000000>2^32","", "#-")
${DIE}ecmcExit Error: HOME_VELO to high (max 2^32/1000000)

#- Die HOME_ACC is to high (max 32 bit uint)
ecmcEpicsEnvSetCalcTernary(DIE,"${HOME_ACC=${MOT_HOME_ACC}}*1000000>2^32","", "#-")
${DIE}ecmcExit Error: HOME_ACC to high (max 2^32/1000000)


#- Die HOME_METHOD_ID is to high or low (max 8bit int)
ecmcEpicsEnvSetCalcTernary(DIE,"${HOME_METHOD_ID=${MOT_HOME_METHOD_ID}}>2^7 or ${HOME_METHOD_ID=${MOT_HOME_METHOD_ID}}<-2^7","", "#-")
${DIE}ecmcExit Error: Home method id out of range (allowed 8 bit int: -128..127)
