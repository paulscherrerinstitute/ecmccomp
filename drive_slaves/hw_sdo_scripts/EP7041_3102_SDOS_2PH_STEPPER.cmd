#==============================================================================
# EP7041_3102_SDOS_2PH_STEPPER.cmd
#-d /**
#-d   \brief SDOS for EP7041-3102 drive
#-d   \details Parametrization of EP7041-3102
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Note EP7041-3102 differs from EL7041 since no resistance and EMF settings exits.

#- =========== Validate resistance ============
ecmcEpicsEnvSetCalcTernary(DIE,"${R_COIL_MOHM=${MOT_R_COIL_MOHM}} < 0","", "#-")
${DIE}ecmcExit Error: Coil resistance invalid
epicsEnvUnset(DIE)

#- Set max current [mA]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x1,${I_MAX_MA_VALID},2)"
epicsEnvUnset(I_MAX_MA_VALID)

#- Reduced current [mA]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x2,${I_STDBY_MA_VALID},2)"
epicsEnvUnset(I_STDBY_MA_VALID)

#- Nominal voltage [mV]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x3,${U_NOM_MV_VALID},2)"
epicsEnvUnset(U_NOM_MV_VALID)

#- Motor steps []
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x6,${STEPS=${MOT_STEPS=200}},2)"
epicsEnvUnset(STEPS)

#- Invert motor polarity
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8012,0x9,${INV_DIR=0},1)"
epicsEnvUnset(INV_DIR)

#- Speed Range
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8012,0x5,${SPEED_RANGE=1},1)"
epicsEnvUnset(SPEED_RANGE)

#- Settings done use ecmcConfig instead of ecmcConfigOrDie since older versions of ecmc do not support the command
ecmcConfig "Cfg.EcSetSlaveSDOSettingsDone(${COMP_S_ID},${CH_ID=1},1)"
