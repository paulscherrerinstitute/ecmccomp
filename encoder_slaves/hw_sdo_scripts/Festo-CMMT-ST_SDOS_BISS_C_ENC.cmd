#==============================================================================
# Festo-CMMT-ST_SDOS_BISS_C_ENC.cmd
#-d /**
#-d   \brief SDOS for Festo CMMT-ST BISS-C interface
#-d   \details Parametrization of Festo CMMT-ST BISS C
#-d   \author Anders Sandström
#-d   \file
#-d */  

#- 0x226E:01: Invert direction (default 0)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x226E,0x1,${INV_DIR=0},1)"

#- 0x226E:01: Select BISS-C encoder
#- 0: Without encoder 
#- 7: Incremental encoder
#- 8: BISS-C (choose BISS)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x2130,0x7D,8,S32)"

#- Single turn bits


