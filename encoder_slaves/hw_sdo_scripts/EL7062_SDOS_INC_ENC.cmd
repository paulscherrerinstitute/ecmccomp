#==============================================================================
# EL7062_INC_ENC.cmd
#-d /**
#-d   \details Parametrization of incremental encoder for EL7062
#-d   \author Anders Sandström
#-d   \file
#-d */

#-####################################
#- Encoder CH1: 0x8008
#- Encoder CH2: 0x8108

ecmcEpicsEnvSetCalc(CH_ID_X,"${CH_ID=1}-1")
epicsEnvSet(SDO_INDEX,"0x8${CH_ID_X}08")

#- Encoder type
#- 0: disabled
#- 1: rs422
#- 2: TTL single ended
#- 6: TTL single ended, filters disabled 
#- 7: Open collector
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x12,${TYPE=1},2)"
epicsEnvUnset(TYPE)

#- Invert encoder direction (default 0)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x1,${INV_DIR=0},1)"
epicsEnvUnset(INV_DIR)

#- Resolution (4 fold)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x13,${ST_ENC_RES=${ENC_ST_RES=4096}},4)"
epicsEnvUnset(ST_ENC_RES)
epicsEnvUnset(ENC_ST_RES)

ecmcEpicsEnvSetCalc(CH_ID_X,"${CH_ID=1}-1")
epicsEnvSet(SDO_INDEX,"0x8${CH_ID_X}01")

#-d             TP1_POS_SRC       : Touchprobe 1 source
#-d                               PRIM: primary encoder (open loop counter)
#-d                               SEC: secondary encoder (incremental encoder)
#-d             TP2_POS_SRC       : Touchprobe 2 source
#-d                               PRIM: primary encoder (open loop counter)
#-d                               SEC: secondary encoder (incremental encoder)

ecmcEpicsEnvSetCalcTernary(EXE_TP,"'SEC' in '${TP1_POS_SRC=0}' or 'PRIM' in '${TP1_POS_SRC=0}'","", "#-")
${EXE_TP}ecmcEpicsEnvSetCalcTernary(TP_VALUE,"'SEC' in '${TP1_POS_SRC=0}'","1", "0")
${EXE_TP}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x15,${TP_VALUE=0},2)"
epicsEnvUnset(EXE_TP)
epicsEnvUnset(TP_VALUE)

ecmcEpicsEnvSetCalcTernary(EXE_TP,"'SEC' in '${TP2_POS_SRC=0}' or 'PRIM' in '${TP2_POS_SRC=0}'","", "#-")
${EXE_TP}ecmcEpicsEnvSetCalcTernary(TP_VALUE,"'SEC' in '${TP2_POS_SRC=0}'","1", "0")
${EXE_TP}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x16,${TP_VALUE=0},2)"
epicsEnvUnset(EXE_TP)
epicsEnvUnset(TP_VALUE)

#-d             TP1_TRG       : Touchprobe 1 trigger
#-d                               TPBI: touch probe input 1  (CoE value 1 (BI1))
#-d                               INDEX: encoder index pulse (CoE value 5)
#-d             TP2_TRG       : Touchprobe 2 trigger
#-d                               TPBI: touch probe input 2  (CoE value 2 (BI2))
#-d                               INDEX: encoder index pulse (CoE value 5)
ecmcEpicsEnvSetCalcTernary(EXE_TP,"'TPBI' in '${TP1_TRG=0}' or 'INDEX' in '${TP1_TRG=0}'","", "#-")
${EXE_TP}ecmcEpicsEnvSetCalcTernary(TP_VALUE,"'INDEX' in '${TP1_TRG=0}'","5", "1")
${EXE_TP}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x11,${TP_VALUE=0},2)"
epicsEnvUnset(EXE_TP)
epicsEnvUnset(TP_VALUE)

ecmcEpicsEnvSetCalcTernary(EXE_TP,"'TPBI' in '${TP2_TRG=0}' or 'INDEX' in '${TP2_TRG=0}'","", "#-")
${EXE_TP}ecmcEpicsEnvSetCalcTernary(TP_VALUE,"'INDEX' in '${TP2_TRG=0}'","5", "2")
${EXE_TP}ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x11,${TP_VALUE=0},2)"
epicsEnvUnset(EXE_TP)
epicsEnvUnset(TP_VALUE)
