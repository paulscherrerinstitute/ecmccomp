#-d /**
#-d   \brief hardware script for EL3174_0to20mA-Sensor-chX
#-d   \details Parametrization Default SDO settings for EL3174
#-d   \author Anders Sandstroem
#-d   \file
#-d   \pre Environment variables needed:
#-d   \pre CH_ID_LOCAL Channel id 0..(X-1)
#-d   \pre ECMC_EC_SLAVE_NUM = slave number
#-d */

#- Input signal type
#- 0x02 = +-10V (default)
#- 0x0E = 0..10V
#- 0x11 = -20..20mA
#- 0x12 = 0..20mA
#- 0x13 = 4..20mA
#- 0x14 = 4..20mA (NAMUR)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x80${CH_ID_LOCAL}D,0x11,0x12,2)"

#- Scaler
#- 0x00 = Extended range (default)
#- 0x03 = Legacy range
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x80${CH_ID_LOCAL}D,0x11,0,2)"
