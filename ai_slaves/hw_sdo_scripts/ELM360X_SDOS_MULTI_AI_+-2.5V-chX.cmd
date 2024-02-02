#-d /**
#-d   \brief hardware script for ELM360X for +-2.5V range
#-d   \details Parametrization of ELM360X for +-2.5V range used for voltage measurement (not IEPE)
#-d   \author Anders Sandstroem
#-d   \file
#-d   \pre Environment variables needed:
#-d   \pre CH_ID_LOCAL Channel id 0..(X-1)
#-d   \pre ECMC_EC_SLAVE_NUM = slave number
#-d */

#- +-2.5V Setting (99)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x80${CH_ID_LOCAL}0,0x1,99,2)"
#- IEPE AC coupling (off)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x80${CH_ID_LOCAL}0,0x3,0,2)"
#- IEPE Bias current (0mA)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x80${CH_ID_LOCAL}0,0x7,0,1)"
