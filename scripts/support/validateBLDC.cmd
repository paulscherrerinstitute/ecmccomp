#==============================================================================
# validateBLDC.cmd
#-d /**
#-d   \brief Common script for validation of BLDC
#-d   \author Anders Sandström
#-d   \file

#-===== Validate currents ===

#- Reduce allowed motor current if drive cannot support the current
ecmcEpicsEnvSetCalcTernary(MOT_I_MAX_MA,"${MOT_I_MAX_MA}>${DRV_I_MAX_MA}",${DRV_I_MAX_MA},${MOT_I_MAX_MA})

#- Run current
epicsEnvSet(I_MAX_MA_VALID, ${I_MAX_MA=${MOT_I_MAX_MA}})

#- Die if to high current
ecmcEpicsEnvSetCalcTernary(DIE,"${I_MAX_MA_VALID}>${MOT_I_MAX_MA}","", "#-")
${DIE}ecmcExit Error: Current setting too high for motor

#- Die if to high current
ecmcEpicsEnvSetCalcTernary(DIE,"${I_MAX_MA_VALID}>${DRV_I_MAX_MA}","", "#-")
${DIE}ecmcExit Error: Current setting too high for drive

#- Ensure I_MAX_MA <= MOT_I_MAX_MA
ecmcEpicsEnvSetCalcTernary(I_MAX_MA_VALID,"${I_MAX_MA_VALID}>${MOT_I_MAX_MA}",${MOT_I_MAX_MA},${I_MAX_MA})

#-===== Validate voltage ===

#- Reduce the allowed motor voltage if drive cannot support the voltage
ecmcEpicsEnvSetCalcTernary(MOT_U_MAX_MV,"${MOT_U_MAX_MV}>${DRV_U_MAX_MV}",${DRV_U_MAX_MV},${MOT_U_MAX_MV})

epicsEnvSet(U_NOM_MV_VALID, ${U_NOM_MV=${MOT_U_MAX_MV}})

#- Die if to high current
ecmcEpicsEnvSetCalcTernary(DIE,"${U_NOM_MV_VALID}>${MOT_U_MAX_MV}","", "#-")
${DIE}ecmcExit Error: Voltage setting too high for motor

epicsEnvUnset(DIE)
