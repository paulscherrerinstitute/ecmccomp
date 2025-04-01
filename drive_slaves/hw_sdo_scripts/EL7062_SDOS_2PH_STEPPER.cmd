#==============================================================================
# EL7062_SDOS_2PH_STEPPER.cmd
#-d /**
#-d   \brief SDOS for EL7062 drive
#-d   \details Parametrization of EL7062
#-d   \author Anders Sandström
#-d   \file
#-d */

#-####################################
#- Motor CH1: 0x8011
#- Motor CH2: 0x8111
ecmcEpicsEnvSetCalc(CH_ID_X,"${CH_ID=1}-1")
epicsEnvSet(SDO_INDEX,"0x8${CH_ID_X}11")

#- =========== Resistance ============
ecmcEpicsEnvSetCalcTernary(DIE,"${R_COIL_MOHM=${MOT_R_COIL_MOHM}} < 0","", "#-")
${DIE}ecmcExit Error: Coil resistance invalid

#- =========== Inductance ============
ecmcEpicsEnvSetCalcTernary(DIE,"${L_COIL_UH=${MOT_L_COIL_UH}} < 0","", "#-")
${DIE}ecmcExit Error: Coil inductance invalid.

#- Set max current [mA]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x12,${I_MAX_MA_VALID},4)"
#- Configured motor current
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x34,${I_MAX_MA_VALID},4)"

#- Nominal voltage [cV]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0xF800,0x10,${U_NOM_MV_VALID},4)"

#- Coil resistance [mOhm]
epicsEnvSet(R_COIL_MOHM,${R_COIL_MOHM=${MOT_R_COIL_MOHM}})
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x30,${R_COIL_MOHM},4)"
epicsEnvUnset(R_COIL_MOHM)

#- Motor steps []
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x33,${STEPS=${MOT_STEPS=200}},4)"
epicsEnvUnset(STEPS)

#- Coil inductance [0.01mH]
epicsEnvSet(L_COIL_UH,${L_COIL_UH=${MOT_L_COIL_UH}})
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x19,${L_COIL_UH},2)"
epicsEnvUnset(L_COIL_UH)

#-####################################
#- Drive CH1: 0x8010
#- Drive CH2: 0x8110
epicsEnvSet(SDO_INDEX,"0x8${CH_ID_X}10")

#- Invert motor polarity
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x65,${INV_DIR=0},1)"
epicsEnvUnset(INV_DIR)

#- Reduced current [mA]
ecmcEpicsEnvSetCalc(STDBY_CURR_PPK,"${I_STDBY_MA_VALID}/${I_MAX_MA_VALID}*1000")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x72,${STDBY_CURR_PPK},2)"
epicsEnvUnset(STDBY_CURR_PPK)

#- Cleanup
epicsEnvUnset(CH_ID_X)
