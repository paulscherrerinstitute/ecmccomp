#==============================================================================
# HWtemplate.cmd
#-d /**
#-d   \brief Command that can be used as a base template for hardware and component configurations.
#-d
#-d  Example:
#-d  file "${ecmccomp_DIR}HWtemplate.cmd"{
#-d     pattern {  SLAVE_ID, HW_DESC, COMP,                                  SLAVE_MACROS,  COMP_CH, COMP_MACROS                   }
#-d             {  1,        EL3004,  -1,                                    "T_SMP_MS=1",  -1,      -1                            }
#-d             {  2,        EL5001,  -1,                                     -1         ,  -1,      -1                            }
#-d             {  3,        EL1008,  -1,                                     -1         ,  -1,      -1                            }
#-d             {  4,        EL7031,  "Motor-OrientalMotor-PK267JB-Parallel", -1         ,   1,      "I_MAX_MA=500,I_STDBY_MA=100" }
#-d             {  12,       EL7037,  "Motor-OrientalMotor-PK267JB-Parallel", -1         ,   1,      "I_MAX_MA=500,I_STDBY_MA=100" }
#-d     }
#-d
#-d The substitution file then can be loaded with one of the following commands in ecmccfg:
#-d  * ${SCRIPTEXEC} ${ecmccfg_DIR}loadSubstHw.cmd, "FILE=./hw.subst"
#-d  * ${SCRIPTEXEC} ${ecmccfg_DIR}loadSubstConfig.cmd, "FILE=./complete.subst"
#-d

#- Do not allow call to addSlave.cmd for same slave twice in a row
ecmcEpicsEnvSetCalcTernary(BLOCKSLAVE,"'${SLAVE_ID=-1}'=='${ECMC_COMP_SUBST_OLD_S_ID}'","# Block call to addSlave.cmd: Not allowed to add same slave twice.", "")
${BLOCKSLAVE}${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=$(SLAVE_ID), HW_DESC=${HW_DESC},MACROS='${SLAVE_MACROS=}'"
epicsEnvSet(ECMC_COMP_SUBST_OLD_S_ID,${ECMC_EC_SLAVE_NUM})
epicsEnvUnset(BLOCKSLAVE)

#- Check if invalid COMP or COMP_CH then block
ecmcEpicsEnvSetCalcTernary(BLOCKCOMP,"'${COMP=-1}'=='-1' or ${COMP_CH=-1}==-1","# Block call to applyComponent.cmd: No Valid component or channel.", "")
${BLOCKCOMP}${SCRIPTEXEC} ${ecmccomp_DIR}applyComponent.cmd "SLAVE_ID=$(SLAVE_ID),HW_DESC=${HW_DESC},COMP=${COMP},CH_ID=${COMP_CH},MACROS='${COMP_MACROS}'"
epicsEnvUnset(BLOCKCOMP)
