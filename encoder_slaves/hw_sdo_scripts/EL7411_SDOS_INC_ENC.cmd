#==============================================================================
# EL7411_INC_ENC.cmd
#-d /**
#-d   \brief SDOS for Festo-CMMT-ST drive incremental encoder intreface
#-d   \details Parametrization of Festo-CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Invert encoder direction (default 0)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8008,0x1,${INV_DIR=0},1)"
epicsEnvUnset(INV_DIR)

#- enable encoder power supply
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8008,0x2,${ENA_POWER=1},1)"
epicsEnvUnset(ENA_POWER)

#- enable C input (index)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8008,0x5,${ENA_INDEX=1},1)"
epicsEnvUnset(ENA_INDEX)

#- Encoder power supply mV
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8008,0x11,${U_NOM_MV=5000},4)"
epicsEnvUnset(U_NOM_MV)

#- Encoder type
#- 0: disabled
#- 1: rs422
#- 2: TTL single ended
#- 3: HTL differential
#- 4: HTL single ended
#- 5: rs422 high impedance
#- 6: TTL single ended, filters disabled 
#- 7: Open collector
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8008,0x12,${TYPE=1},2)"
epicsEnvUnset(TYPE)

#- Resolution (4 fold)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8008,0x13,${ST_ENC_RES=${ENC_ST_RES=4096}},4)"
epicsEnvUnset(ST_ENC_RES)
epicsEnvUnset(ENC_ST_RES)
