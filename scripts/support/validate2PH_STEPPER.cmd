#==============================================================================
# validate2PH_STEPPER.cmd
#-d /**
#-d   \brief Script for validation of 2PH STEPPER
#-d   \author Anders Sandström
#-d   \file

#-===== Validate HW_DESC matches component ===
ecmcEpicsEnvSetCalcTernary(DIE,"'2PH_STEPPER' in '${SLAVE_TYPE}'","#-", "")
${DIE}ecmcExit Error: Component and slave do not match

#-===== Validate currents ===
#- =========== Max current ============

#- Override MOT_I_MAX_MA if generic cfg
ecmcIf("${MOT_I_MAX_MA}=-1")
${IF_TRUE}epicsEnvSet(MOT_I_MAX_MA,$(I_MAX_MA=-1))
ecmcEndIf()

#- Reduce allowed motor current if drive cannot support the current
ecmcEpicsEnvSetCalcTernary(MOT_I_MAX_MA,"${MOT_I_MAX_MA}>${DRV_I_MAX_MA}",${DRV_I_MAX_MA},${MOT_I_MAX_MA})

epicsEnvSet(I_MAX_MA_VALID, ${I_MAX_MA=${MOT_I_MAX_MA}})

#- Die if to high current
ecmcEpicsEnvSetCalcTernary(DIE,"${I_MAX_MA_VALID}>${MOT_I_MAX_MA}","", "#-")
${DIE}ecmcExit Error: Current setting too high for motor

#- Die if to high current
ecmcEpicsEnvSetCalcTernary(DIE,"${I_MAX_MA_VALID}>${DRV_I_MAX_MA}","", "#-")
${DIE}ecmcExit Error: Current setting too high for drive

#- Ensure I_MAX_MA <= MOT_I_MAX_MA
ecmcEpicsEnvSetCalcTernary(I_MAX_MA_VALID,"${I_MAX_MA_VALID}>${MOT_I_MAX_MA}",${MOT_I_MAX_MA},${I_MAX_MA_VALID})

ecmcIf("${I_MAX_MA_VALID}<0")
${IF_TRUE} ecmcExit I_MAX_MA_VALID not valid, please specify a correct current
ecmcEndIf()

#- =========== Stdby current ============
epicsEnvSet(I_STDBY_MA_VALID, ${I_STDBY_MA=${MOT_I_STDBY_MA}})

#- Die if to high current
ecmcEpicsEnvSetCalcTernary(DIE,"${I_STDBY_MA_VALID}>${MOT_I_MAX_MA}","", "#-")
${DIE}ecmcExit Error: Standby Current setting too high for motor

#- Die if to high current
ecmcEpicsEnvSetCalcTernary(DIE,"${I_STDBY_MA_VALID}>${DRV_I_MAX_MA}","", "#-")
${DIE}ecmcExit Error: Standby Current setting too high for drive

#- Die if I_STDBY_MA_VALID > I_MAX_MA_VALID
ecmcEpicsEnvSetCalcTernary(DIE,"${I_STDBY_MA_VALID}>${I_MAX_MA_VALID}","", "#-")
${DIE}ecmcExit Error: Standby Current setting higher than run current

#- Ensure I_STDBY_MA <= I_MAX_MA
ecmcEpicsEnvSetCalcTernary(I_STDBY_MA_VALID,"${I_STDBY_MA_VALID}>${I_MAX_MA_VALID}",${I_MAX_MA_VALID},${I_STDBY_MA_VALID})

ecmcIf("${I_STDBY_MA_VALID}<0")
${IF_TRUE} ecmcExit I_STDBY_MA_VALID not valid, please specify a correct standby current
ecmcEndIf()

#- =========== Voltage ============

#- Reduce the allowed motor voltage if drive cannot support the voltage
ecmcEpicsEnvSetCalcTernary(MOT_U_MAX_MV,"${MOT_U_MAX_MV}>${DRV_U_MAX_MV}",${DRV_U_MAX_MV},${MOT_U_MAX_MV})

epicsEnvSet(U_NOM_MV, ${U_NOM_MV=${MOT_U_MAX_MV}})

#- Die if to high voltage
ecmcEpicsEnvSetCalcTernary(DIE,"${U_NOM_MV}>${MOT_U_MAX_MV}","", "#-")
${DIE}ecmcExit Error: Nominal voltage too high for motor

#- ecmcEpicsEnvSetCalcTernary(DIE,"${U_NOM_MV}>${DRV_U_MAX_MV}","", "#-")
#- ${DIE}ecmcExit Error: Nominal voltage too high for drive

#- Ensure U_NOM_MV <= DRV_U_MAX_MV
ecmcEpicsEnvSetCalcTernary(U_NOM_MV_VALID,"${U_NOM_MV}>${DRV_U_MAX_MV}",${DRV_U_MAX_MV},${U_NOM_MV})

epicsEnvUnset(DIE)
