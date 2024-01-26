#==============================================================================
# Festo-CMMT-ST_SDOS_INC_ENC.cmd
#-d /**
#-d   \brief SDOS for Festo-CMMT-ST drive incremental encoder intreface
#-d   \details Parametrization of Festo-CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d */

#- 0x226E:01: Invert direction (default 0)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x226E,0x1,${INV_DIR=0},1)"

#- 0x226E:01: Select BISS-C encoder
#- 0: Without encoder 
#- 7: Incremental encoder
#- 8: BISS-C (choose BISS)
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2130,0x7D,7,S32)"

#- Singleturn resolution
#- 0x2138:01: Single turn resolution 
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2138,0x1,${ST_ENC_RES=${ENC_ST_ENC_RES=500}},U32)"
