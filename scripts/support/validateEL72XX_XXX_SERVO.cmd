#==============================================================================
# validateEL72XX_XXX_SERVO.cmd
#-d /**
#-d   \brief Common script for validation of EL72XX_OCT_SERVO and EL72XX_RES_SERVO
#-d   \author Anders Sandström
#-d   \file

#-===== Validate currents ===
#- Run current
epicsEnvSet(I_MAX_MA, ${I_MAX_MA=${MOT_I_MAX_MA}})

#- Ensure I_MAX_MA <= MOT_I_MAX_MA
ecmcEpicsEnvSetCalcTernary(I_MAX_MA,"${I_MAX_MA}>${MOT_I_MAX_MA}",${MOT_I_MAX_MA},${I_MAX_MA})

#- Ensure I_MAX_MA <= DRV_I_MAX_MA
ecmcEpicsEnvSetCalcTernary(I_MAX_MA,"${I_MAX_MA}>${DRV_I_MAX_MA}",${DRV_I_MAX_MA},${I_MAX_MA})

#-===== Validate voltage ===
epicsEnvSet(U_NOM_MV, ${U_NOM_MV=${MOT_U_MAX_MV}})

#- Ensure U_NOM_MV <= DRV_U_MAX_MV
ecmcEpicsEnvSetCalcTernary(U_NOM_MV,"${U_NOM_MV}>${DRV_U_MAX_MV}",${DRV_U_MAX_MV},${U_NOM_MV})
