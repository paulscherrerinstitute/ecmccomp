#==============================================================================
# validate2PH_STEPPER.cmd
#-d /**
#-d   \brief Script for validation of 2PH STEPPER
#-d   \author Anders Sandström
#-d   \file

#-===== Validate HW_DESC matches component ===
ecmcEpicsEnvSetCalcTernary(DIE,"'${SLAVE_TYPE}'!='2PH_STEPPER'","", "#-")
${DIE}ecmcExit Error: Component and slave do not matching

#-===== Validate currents ===
#- Run current
epicsEnvSet(I_MAX_MA, ${I_MAX_MA=${MOT_I_MAX_MA}})

#- Ensure I_MAX_MA <= MOT_I_MAX_MA
ecmcEpicsEnvSetCalcTernary(I_MAX_MA,"${I_MAX_MA}>${MOT_I_MAX_MA}",${MOT_I_MAX_MA},${I_MAX_MA})

#- Ensure I_MAX_MA <= DRV_I_MAX_MA
ecmcEpicsEnvSetCalcTernary(I_MAX_MA,"${I_MAX_MA}>${DRV_I_MAX_MA}",${DRV_I_MAX_MA},${I_MAX_MA})

#- Stdby current
epicsEnvSet(I_STDBY_MA, ${I_STDBY_MA=${MOT_I_STDBY_MA}})

#- Ensure I_STDBY_MA <= I_MAX_MA
ecmcEpicsEnvSetCalcTernary(I_STDBY_MA,"${I_STDBY_MA}>${I_MAX_MA}",${I_MAX_MA},${I_STDBY_MA})

#-===== Validate voltage ===
epicsEnvSet(U_NOM_MV, ${U_NOM_MV=${MOT_U_MAX_MV}})

#- Ensure U_NOM_MV <= DRV_U_MAX_MV
ecmcEpicsEnvSetCalcTernary(U_NOM_MV,"${U_NOM_MV}>${DRV_U_MAX_MV}",${DRV_U_MAX_MV},${U_NOM_MV})

epicsEnvUnset(DIE)
