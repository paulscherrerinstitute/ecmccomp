#==============================================================================
# Festo-CMMT-ST_ReInit.cmd
#-d /**
#-d   \brief Reinit festo drive
#-d   \details Parametrization of Festo-CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Reinit drive (seems it needs to be like this..)
ecmcConfigOrDie "Cfg.EcWriteSdo(${COMP_S_ID},0x2003,0x1,0,1)"
epicsThreadSleep 0.1
ecmcConfigOrDie "Cfg.EcWriteSdo(${COMP_S_ID},0x2003,0x1,1,1)"
epicsThreadSleep 0.1
ecmcConfigOrDie "Cfg.EcWriteSdo(${COMP_S_ID},0x2003,0x1,0,1)"
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2003,0x1,0,S8)"
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2003,0x1,1,S8)"
