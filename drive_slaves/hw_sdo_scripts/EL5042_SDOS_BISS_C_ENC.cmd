#-d /**
#-d   \brief SDOS for EL5042 encoder interface 
#-d   \details Parametrization of EL5042
#-d   \author Anders Sandström
#-d   \file
#-d */  

#- Calculate SDO adress based on CH (0x8008 for CH1, 0x8018 for CH2)
ecmcEpicsEnvSetCalc(CH_ID_M1,"${CH_ID=1}-1")
epicsEnvSet(SDO_INDEX,"0x80${CH_ID_M1}8")
epicsEnvUnset(CH_ID_M1)

#- 0x80p8:02: Disable Status Bits (default 0)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x2,${ENC_DIS_STAT_BITS=0},1)"
epicsEnvUnset(ENC_DIS_STAT_BITS)

#- 0x80p8:03: CRC Invert (default 1 ?)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x3,${ENC_CRC_INV=1},1)"
epicsEnvUnset(ENC_CRC_INV)

#- 0x80p8:11: CRC Polynom (default 67)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x11,${ENC_CRC_POLY=67},4)"
epicsEnvUnset(ENC_CRC_POLY)

#- 0x80p8:12: Supply voltage
#- 50: 5V (default)
#- 90: 9V
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x12,${ENC_U_SUP_VLT=50},1)"
epicsEnvUnset(ENC_U_SUP_VLT)

#- 0x80p8:13: Clock Frequency
#- 0: 10 MHz (default)
#- 1: 5 MHz
#- 2: 3.33 MHz
#- 3: 2.5 MHz
#- 4: 2 MHz
#- 9: 1 MHz (Max for SSI)
#- 17: 500 kHz
#- 19: 250 kHz <--
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x13,${CLK_FRQ=${ENC_CLK_FRQ}},1)"
epicsEnvUnset(CLK_FRQ)
epicsEnvUnset(ENC_CLK_FRQ)


#- 0x80p8:14: Coding
#- 0: Dual code active (default)
#- 1: Gray code active
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x14,${ENC_CODEING=0},1)"

#- 0x80p8:15: Multiturn [Bit] Number of multiturn bits
#- default 12
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x15,${ENC_MT_BITS=0},1)"
epicsEnvUnset(ENC_MT_BITS)

#- 0x80p8:16: Singleturn [Bit] Number of singleturn bits
#- default 13
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x16,${ENC_ST_BITS=0},1)"
epicsEnvUnset(ENC_ST_BITS)

#- 0x80p8:17: Offset LSB Bit [Bit] Number of “right aligned” Offset bits
#- default 0
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x17,${ENC_OFF_BITS=0},1)"
epicsEnvUnset(ENC_OFF_BITS)

#- 0x80p8:18: Mode
#- 0: BiSS-C mode (default)
#- 1: SSI mode
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x18,${ENC_MODE=0},1)"
epicsEnvUnset(ENC_MODE)
