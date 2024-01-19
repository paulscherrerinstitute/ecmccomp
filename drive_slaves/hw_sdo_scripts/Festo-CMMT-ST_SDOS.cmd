#-d /**
#-d   \brief SDOS for Festo-CMMT-ST drive
#-d   \details Parametrization of Festo-CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d */



#-#- Set max current [mA]
#-ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x1,${I_MAX_MA_VALID},2)"
#-epicsEnvUnset(I_MAX_MA_VALID)
#-
#-#- Reduced current [mA]
#-ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x2,${I_STDBY_MA_VALID},2)"
#-epicsEnvUnset(I_STDBY_MA_VALID)
#-
#-#- Nominal voltage [mV]
#-ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x3,${U_NOM_MV_VALID},2)"
#-epicsEnvUnset(U_NOM_MV_VALID)
#-
#-#- Coil resistance [cOhm]
#-epicsEnvSet(R_COIL_MOHM,${R_COIL_MOHM=${MOT_R_COIL_MOHM}})
#-ecmcEpicsEnvSetCalc(R_COIL,"${R_COIL_MOHM}*0.1","%d")
#-ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x4,${R_COIL},2)"
#-epicsEnvUnset(R_COIL)
#-epicsEnvUnset(R_COIL_MOHM)
#-epicsEnvUnset(MOT_R_COIL_MOHM)
#-
#-#- Motor steps []
#-ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x6,${STEPS=${MOT_STEPS=200}},2)"
#-epicsEnvUnset(MOT_STEPS)
#-epicsEnvUnset(STEPS)
#-
#-#- Motor EMF  mV/(rad/s)
#-ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x5,${EMF=${MOT_EMF=0}},2)"
#-epicsEnvUnset(MOT_EMF)
#-epicsEnvUnset(EMF)
#-
#-#- Invert motor polarity
#-ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8012,0x9,${INV_DIR=0},1)"
#-epicsEnvUnset(INV_DIR)
