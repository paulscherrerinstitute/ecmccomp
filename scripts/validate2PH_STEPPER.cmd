#==============================================================================
# validate2PH_STEPPER.cmd
#-d /**
#-d   \brief Script for validation of 2PH STEPPER
#-d   \author Anders Sandström
#-d   \file

#-===== Validate HW_DESC matches component ===
ecmcEpicsEnvSetCalcTernary(DIE,"'${SLAVE_TYPE}'!='2PH_STEPPER'","", "#-")
${DIE}ecmcExit Error: Component and slave do not matching

#-===== Validate CHANNEL ===
ecmcEpicsEnvSetCalcTernary(DIE,"${CH_ID=1}>${SLAVE_CHANNELS}","", "#-")
${DIE}ecmcExit Error: CHANNEL out of range (not supported by the slave). 

#-===== Validate currents ===
#- Run current
epicsEnvSet(I_RUN_MA, ${I_RUN_MA=${MOT_I_RUN_MA}})

#- Ensure I_RUN_MA <= MOT_I_MAX_MA
ecmcEpicsEnvSetCalcTernary(I_RUN_MA,"${I_RUN_MA}>${MOT_I_MAX_MA}",${MOT_I_MAX_MA},${I_RUN_MA})

#- Ensure I_RUN_MA <= DRV_I_MAX_MA
ecmcEpicsEnvSetCalcTernary(I_RUN_MA,"${I_RUN_MA}>${DRV_I_MAX_MA}",${DRV_I_MAX_MA},${I_RUN_MA})

#- Stdby current
epicsEnvSet(I_STDBY_MA, ${I_STDBY_MA=${MOT_I_STDBY_MA}})

#- Ensure I_STDBY_MA <= I_RUN_MA
ecmcEpicsEnvSetCalcTernary(I_STDBY_MA,"${I_STDBY_MA}>${I_RUN_MA}",${I_RUN_MA},${I_STDBY_MA})

#-===== Validate voltage ===
epicsEnvSet(U_NOM_MV, ${U_NOM_MV=${MOT_U_MAX_MV}})

#- Ensure U_NOM_MV <= DRV_U_MAX_MV
ecmcEpicsEnvSetCalcTernary(U_NOM_MV,"${U_NOM_MV}>${DRV_U_MAX_MV}",${DRV_U_MAX_MV},${U_NOM_MV})

epicsEnvUnset(DIE)
