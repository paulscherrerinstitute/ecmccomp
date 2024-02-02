#==============================================================================
# EL70X7_SDOS_2PH_STEPPER.cmd
#-d /**
#-d   \brief SDOS for EL70X7 drive
#-d   \details Parametrization of EL70X7
#-d   \author Anders Sandström
#-d   \file
#-d */

#- =========== Resistance ============
ecmcEpicsEnvSetCalcTernary(DIE,"${R_COIL_MOHM=${MOT_R_COIL_MOHM}} < 0","", "#-")
${DIE}ecmcExit Error: Coil resistance invalid

#- =========== Inductance ============
ecmcEpicsEnvSetCalcTernary(DIE,"${L_COIL_UH=${MOT_L_COIL_UH}} < 0","", "#-")
${DIE}ecmcExit Error: Coil inductance invalid.

#- Set max current [mA]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x1,${I_MAX_MA_VALID},2)"

#- Reduced current [mA]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x2,${I_STDBY_MA_VALID},2)"

#- Nominal voltage [cV]
ecmcEpicsEnvSetCalc(U_NOM_MV_VALID,"${U_NOM_MV_VALID}*0.1","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x3,${U_NOM_MV_VALID},2)"

#- Coil resistance [cOhm]
epicsEnvSet(R_COIL_MOHM,${R_COIL_MOHM=${MOT_R_COIL_MOHM}})
ecmcEpicsEnvSetCalc(R_COIL,"${R_COIL_MOHM}*0.1","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x4,${R_COIL},2)"
epicsEnvUnset(R_COIL)
epicsEnvUnset(R_COIL_MOHM)

#- Motor steps []
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x6,${STEPS=${MOT_STEPS=200}},2)"
epicsEnvUnset(STEPS)

#- Coil inductance [0.01mH]
epicsEnvSet(L_COIL_UH,${L_COIL_UH=${MOT_L_COIL_UH}})
ecmcEpicsEnvSetCalc(L_COIL,"${L_COIL_UH}*0.1","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0xA,${L_COIL},2)"
epicsEnvUnset(L_COIL)
epicsEnvUnset(L_COIL_UH)

#- Invert motor polarity
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8012,0x9,${INV_DIR=0},1)"
epicsEnvUnset(INV_DIR)
