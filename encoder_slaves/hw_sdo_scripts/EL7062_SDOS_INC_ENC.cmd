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
