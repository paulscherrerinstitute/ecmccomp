#==============================================================================
# applyComponent.cmd
#- Arguments: HW_DESC, COMPONENT [SLAVE_ID = 0, CHANNEL, MACROS ]
#-d /**
#-d   \brief Script for adding component configuration to a ethercat slave
#-d   \author Anders Sandström
#-d   \file
#-d   \param HW_DESC Hardware descriptor, i.e. EL7037
#-d   \param COMPONENT  Component name
#-d   \param SLAVE_ID  (optional) Slave bus position
#-d   \param CHANNEL   (optional) Channel of slave default to 1
#-d   \param MACROS    (optional) Special macros, depending on slave type:
#-d          2PH_STEPPER:
#-d              I_RUN_MA    : Run current [mA]
#-d              I_STDBY_MA  : Standby current [mA]
#-d              U_RUN_MV    : Supply voltage [mV]
#-d   \note Example calls:
#-d   \note - call w/o SLAVE_ID
#-d   \code
#-d     ${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd, "HW_DESC=EL7037,COMPONENT=Motor-OrientalMotor-PK267JB-Parallel,MACROS='I_RUN_MA=1000'"
#-d */

#- Set variables for component
ecmcFileExist(${ecmccomp_DIR}${COMPONENT}.cmd,1,1)
${SCRIPTEXEC} ${ecmccomp_DIR}${COMPONENT}.cmd

#- Set variables for slave
ecmcFileExist(${ecmccomp_DIR}${HW_DESC}.cmd,1,1)
${SCRIPTEXEC} ${ecmccomp_DIR}${HW_DESC}.cmd

#- Validate and set the variables that should be used if the configs
ecmcFileExist("${ecmccomp_DIR}validate${COMP_TYPE}.cmd",1,1)
${SCRIPTEXEC} ${ecmccomp_DIR}validate${COMP_TYPE}.cmd CHANNEL=${CHANNEL=1},${MACROS=""}

#- Apply configuration
ecmcFileExist("${ecmccomp_DIR}${SLAVE_SCRIPT}.cmd",1,1)
${SCRIPTEXEC} ${ecmccomp_DIR}${SLAVE_SCRIPT}.cmd CHANNEL=${CHANNEL=1}

#- Cleanup
ecmcFileExist("${ecmccomp_DIR}cleanup${COMP_TYPE}.cmd",1,1)
${SCRIPTEXEC} ${ecmccomp_DIR}cleanup${COMP_TYPE}.cmd
