#==============================================================================
# applyComponent.cmd
#- Arguments: HW_DESC, COMPONENT [SLAVE_ID = 0, CH_ID = 1, MACROS='']
#-d /**
#-d   \brief Script for adding component configuration to a ethercat slave
#-d   \author Anders Sandström
#-d   \file
#-d   \param HW_DESC Hardware descriptor, i.e. EL7037
#-d   \param COMP  Component name
#-d   \param SLAVE_ID  (optional) Slave bus position
#-d   \param CH_ID     (optional) Channel of slave default to 1
#-d   \param MACROS    (optional) Special macros, depending on slave type:
#-d          2PH_STEPPER:
#-d              I_RUN_MA    : Run current [mA]
#-d              I_STDBY_MA  : Standby current [mA]
#-d              U_NOM_MV    : Supply voltage [mV]
#-d          EL7211_SERVO:
#-d              I_MAX_MA    : Max current [mA]
#-d              U_NOM_MV    : Supply voltage [mV] 
#-d   \note Example calls:
#-d   \code
#-d     ${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd, "HW_DESC=EL7037,COMP=Motor-OrientalMotor-PK267JB-Parallel,MACROS='I_RUN_MA=1000'"
#-d */

#- Ensure same slave and channel is not added twice in a row
ecmcEpicsEnvSetCalcTernary(BLOCK,"${SLAVE_ID}==${COMP_HW_OLD_SLAVE_ID=-100} and ${COMP_HW_OLD_SLAVE_CH=-100}==${CH_ID}","#-", "")
epicsEnvSet(COMP_HW_OLD_SLAVE_ID,${SLAVE_ID})
epicsEnvSet(COMP_HW_OLD_SLAVE_CH,${CH_ID})

#- Set variables for component
${BLOCK}ecmcFileExist(${ecmccomp_DIR}${COMP}.cmd,1,1)
${BLOCK}${SCRIPTEXEC} ${ecmccomp_DIR}${COMP}.cmd

#- Set variables for slave
${BLOCK}ecmcFileExist(${ecmccomp_DIR}${HW_DESC}.cmd,1,1)
${BLOCK}${SCRIPTEXEC} ${ecmccomp_DIR}${HW_DESC}.cmd

#- Validate and set the variables that should be used in the configs
${BLOCK}ecmcFileExist("${ecmccomp_DIR}validate${COMP_TYPE}.cmd",1,1)
${BLOCK}${SCRIPTEXEC} ${ecmccomp_DIR}validate${COMP_TYPE}.cmd "CH_ID=${CH_ID=1},${MACROS=''}"

#- Apply configuration
${BLOCK}ecmcFileExist("${ecmccomp_DIR}${SLAVE_SCRIPT}.cmd",1,1)
${BLOCK}${SCRIPTEXEC} ${ecmccomp_DIR}${SLAVE_SCRIPT}.cmd CH_ID=${CH_ID=1}

#- Cleanup
${BLOCK}ecmcFileExist("${ecmccomp_DIR}cleanup${COMP_TYPE}.cmd",1,1)
${BLOCK}${SCRIPTEXEC} ${ecmccomp_DIR}cleanup${COMP_TYPE}.cmd
