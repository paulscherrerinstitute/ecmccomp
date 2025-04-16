#==============================================================================
# EL7062_SDOS_CTRL_PARAMS.cmd
#-d /**
#-d   \brief SDOS for EL72XX drive
#-d   \details Parametrization of EL72XX
#-d   \author Anders Sandström
#-d   \file
#-d   \note Macros: I_KP,I_TI,V_KP,V_TI,P_KP
#-d */

ecmcEpicsEnvSetCalc(CH_ID_X,"${CH_ID=1}-1")

#-####################################
#- Drive CH1: 0x8010
#- Drive CH2: 0x8110

epicsEnvSet(SDO_INDEX,"0x8${CH_ID_X}10")

#- Current loop Ti
ecmcIf("${I_TI=-1}>-1")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x12,${I_TI=10},2)"
${IF_TRUE}epicsEnvUnset(I_TI)
ecmcEndIf()

#- Current loop Kp default 100
ecmcIf("${I_KP=-1}>-1")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x13,${I_KP=100},2)"
${IF_TRUE}epicsEnvUnset(I_KP)
ecmcEndIf()

#- Velocity loop Ti default 50
ecmcIf("${V_TI=-1}>-1")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x14,${V_TI=50},4)"
${IF_TRUE}epicsEnvUnset(V_TI)
ecmcEndIf()

#- Velocity loop Kp default 150, only set if not 150
ecmcIf("${V_KP=-1}>-1")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x15,${V_KP=150},4)"
${IF_TRUE}epicsEnvUnset(V_KP)
ecmcEndIf()

#- Position loop Kp default 0, only set if not 0
ecmcIf("${P_KP=-1}>-1")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x53,${P_KP=0},4)"
${IF_TRUE}epicsEnvUnset(P_KP)
ecmcEndIf()

#- Cleanup
epicsEnvUnset(CH_ID_X)
