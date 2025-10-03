#-d /**
#-d   \brief Use to tell ecmc that a channel is not used (for SDO verification)
#-d   \details Tell ecmc that a certain channel is not used and need no SDO cfgs (mainly for drives)
#-d   \author Anders Sandström
#-d   \note 
#-d   The follow macros are supported:
#-d   * CH_ID:     Channel ID to not use

#- Component TYPE []
epicsEnvSet(COMP_TYPE,GENERIC)

#- Settings done use ecmcConfig instead of ecmcConfigOrDie since older versions of ecmc do not support the command
ecmcConfig "Cfg.EcSetSlaveSDOSettingsDone(${COMP_S_ID},${CH_ID=1},1)"

#- Exit early (special case, do not execute all ecmccomp scripts)
epicsEnvSet(ECMC_COMP_EXIT_EARLY,1)
