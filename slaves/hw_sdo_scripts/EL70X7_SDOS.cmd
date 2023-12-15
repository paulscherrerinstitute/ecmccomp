#-d /**
#-d   \brief SDOS for EL70X7 drive
#-d   \details Parametrization of EL70X7
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Set max current [mA]
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x1,${I_MAX_MA},2)"

#- Reduced current [mA]
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x2,${I_STDBY_MA},2)"

#- Nominal voltage [cV]
ecmcEpicsEnvSetCalc(U_NOM_MV,"${U_NOM_MV}*0.1","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x3,${U_NOM_MV},2)"

#- Coil resistance [cOhm]
ecmcEpicsEnvSetCalc(MOT_R_COIL,"${MOT_R_COIL_MOHM}*0.1","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x4,${MOT_R_COIL},2)"
epicsEnvUnset(MOT_R_COIL)

#- Motor steps []
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x6,${MOT_STEPS=200},2)"

#- Coil inductance [0.01mH]
ecmcEpicsEnvSetCalc(MOT_L_COIL,"${MOT_L_COIL_UH}*0.1","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0xA,${MOT_L_COIL},2)"
epicsEnvUnset(MOT_L_COIL)

#- Invert motor polarity
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8012,0x9,${INV_DIR=0},1)"

