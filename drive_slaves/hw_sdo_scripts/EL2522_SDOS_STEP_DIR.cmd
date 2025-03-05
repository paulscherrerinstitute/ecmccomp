#==============================================================================
# EL2522_SDOS_STEP_DIR.cmd
#-d /**
#-d   \brief SDOS for EL2522  step direction drive
#-d   \details Parametrization of EL2522
#-d   \author Anders Sandström
#-d   \file
#-d 
#-d   CH1=0x8000 (32768dec)
#-d   CH2=0x8010 (32768+16 dec)
#-d */

ecmcEpicsEnvSetCalc(SDO_ADDRESS,"32768+(${CH_ID=1}-1)*16","0x%x")

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
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_ADDRESS},0x1,0,1)"

#- Call genric cfg
ecmcFileExist("${ecmccomp_DIR}EL252X_SDOS_STEP_DIR.cmd",1,1)
< ${ecmccomp_DIR}EL252X_SDOS_STEP_DIR.cmd
