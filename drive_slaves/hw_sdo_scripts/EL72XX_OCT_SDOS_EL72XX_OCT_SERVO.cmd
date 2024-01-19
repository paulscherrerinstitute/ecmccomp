#-d /**
#-d   \brief SDOS for EX72XX OCT drive
#-d   \details Parametrization of EX72XX OCT
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Most settings same as EL7201 Resolver version
< ${ecmccomp_DIR}EL72XX_RES_SDOS_EL72XX_RES_SERVO.cmd 

#- Invert motor polarity
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x65,${INV_DIR=0},1)"
epicsEnvUnset(INV_DIR)

#- Encoder offset
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8000,0x17,${ENC_OFF=0},4)"
epicsEnvUnset(ENC_OFF)
