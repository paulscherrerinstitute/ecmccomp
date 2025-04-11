#==============================================================================
# EL7062_SDOS_CTRL_PARAMS.cmd
#-d /**
#-d   \brief SDOS for EL7062 drive
#-d   \details Parametrization of EL7062
#-d   \author Anders Sandström
#-d   \file
#-d   \note Macros: I_KP,I_TI,V_KP,V_TI,P_KP,R_COIL_MOHM,L_COIL_UH
#-d */

#-####################################
#- Motor CH1: 0x8011
#- Motor CH2: 0x8111
ecmcEpicsEnvSetCalc(CH_ID_X,"${CH_ID=1}-1")
epicsEnvSet(SDO_INDEX,"0x8${CH_ID_X}11")

#- =========== Resistance ============
#- Only write if macro is set
ecmcIf("${R_COIL_MOHM=-1}>0")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x30,${R_COIL_MOHM=1400},4)"
${IF_TRUE}epicsEnvUnset(R_COIL_MOHM)
ecmcEndIf()

#- =========== Inductance ============
#- Only write if macro is set (convert to correct unit)
ecmcIf("${L_COIL_UH=-1}>0")
${IF_TRUE}ecmcEpicsEnvSetCalc(L_COIL_SET,"${L_COIL_UH=3900}/10","%d")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x19,${L_COIL_SET=390},2)"
${IF_TRUE}epicsEnvUnset(L_COIL_SET)
${IF_TRUE}epicsEnvUnset(L_COIL_UH)
ecmcEndIf()

#-####################################
#- Drive CH1: 0x8010
#- Drive CH2: 0x8110

epicsEnvSet(SDO_INDEX,"0x8${CH_ID_X}10")

#- Current loop Ti default 50, only set if not 50
ecmcIf("${I_TI=50}!=50")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x12,${I_TI=50},2)"
${IF_TRUE}epicsEnvUnset(I_TI)
ecmcEndIf()

#- Current loop Kp default 50, only set if not 50
ecmcIf("${I_KP=50}!=50")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x13,${I_KP=50},2)"
${IF_TRUE}epicsEnvUnset(I_KP)
ecmcEndIf()

#- Velocity loop Ti default 30, only set if not 30
ecmcIf("${V_TI=30}!=30")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x14,${V_TI=30},4)"
${IF_TRUE}epicsEnvUnset(V_TI)
ecmcEndIf()

#- Velocity loop Kp default 150, only set if not 150
ecmcIf("${V_KP=150}!=150")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x15,${V_KP=150},4)"
${IF_TRUE}epicsEnvUnset(V_KP)
ecmcEndIf()

#- Position loop Kp default 10, only set if not 10
ecmcIf("${P_KP=10}!=10")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x17,${P_KP=10},4)"
${IF_TRUE}epicsEnvUnset(P_KP)
ecmcEndIf()

#- Cleanup
epicsEnvUnset(CH_ID_X)
