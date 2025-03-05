#==============================================================================
# EL2521_SDOS_STEP_DIR.cmd
#-d /**
#-d   \brief SDOS for EL2521  step direction drive
#-d   \details Parametrization of EL2521
#-d   \author Anders Sandström
#-d   \file
#-d 
#-d   CH1=0x8010  (not consistent with EL2522 where ch1 is on 0x8000)
#-d */

epicsEnvSet(SDO_ADDRESS,"0x8010")

#- Adapt A/B on position set:
#- If the counter value is set to "0", the C-track goes into
#- the "high" state.
#- The behavior of channels A and B can be defined in this
#- case.
#- By default the value is FALSE; the position of the C-
#- track relative to A and B is then not changed. If the
#- value is set to TRUE, channels A and B are both set to
#- high. Consequently, a change of state occurs on both
#- channels!
#- Setting 0
#- EL2521 does not have this setting (like EL2522)... 
#- ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_ADDRESS},0x1,0,1)"

#- Call genric cfg
< ${ecmccomp_DIR}EL252X_SDOS_STEP_DIR.cmd
