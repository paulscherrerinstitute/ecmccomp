#==============================================================================
# Festo-CMMT-ST_SDOS_OPENLOOP_ENC.cmd
#-d /**
#-d   \brief SDOS for Festo-CMMT-ST drive incremental encoder intreface
#-d   \details Parametrization of Festo-CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d */

#- 0x226E:01: Invert direction (default 0)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x226E,0x1,${INV_DIR=0},1)"
epicsEnvUnset(INV_DIR)

#- P11616.0.0 0x2130:7D: Select Without encoder
#- 4: Incremental encoder
#- 7: Without encoder 
#- 8: BISS-C
#- Write directlly for reinit to work
ecmcConfigOrDie "Cfg.EcWriteSdo(${COMP_S_ID},0x2130,0x7D,7,4)"
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2130,0x7D,7,S32)"

# Encoder homed P0.2337.0.0
#- 0x2130:63, Set to not homed per default
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2130,0x3F,${HOMED=0},U8)"
epicsEnvUnset(HOMED)

#- Reinit
ecmcFileExist(${ecmccomp_DIR}Festo-CMMT-ST_ReInit.cmd,1,1)
${SCRIPTEXEC} ${ecmccomp_DIR}Festo-CMMT-ST_ReInit.cmd
