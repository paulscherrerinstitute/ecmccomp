#==============================================================================
# EL5042_SDOS_BISS_C_ENC.cmd
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

#- 0x80p8:02: Invert direction (default 0)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x2,${INV_DIR=0},1)"
epicsEnvUnset(ENC_DIS_STAT_BITS)

#- 0x80p8:02: Disable Status Bits (default 0)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x2,${DIS_STAT_BITS=${ENC_DIS_STAT_BITS=0}},1)"
epicsEnvUnset(ENC_DIS_STAT_BITS)

#- 0x80p8:03: CRC Invert (default 1 ?)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x3,${CRC_INV=${ENC_CRC_INV=1}},1)"
epicsEnvUnset(ENC_CRC_INV)

#- 0x80p8:11: CRC Polynom (default 67)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x11,${CRC_POLY=${ENC_CRC_POLY=67}},4)"
epicsEnvUnset(ENC_CRC_POLY)

#- 0x80p8:12: Supply voltage
#- 50: 5V (default)
#- 90: 9V
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x12,${U_SUP_VLT=${ENC_U_SUP_VLT=50}},1)"
epicsEnvUnset(ENC_U_SUP_VLT)

#- 0x80p8:13: Clock Frequency
#- 0: 10 MHz (default)
#- 1: 5 MHz
#- 2: 3.33 MHz
#- 3: 2.5 MHz
#- 4: 2 MHz
#- 9: 1 MHz (Max for SSI)
#- 17: 500 kHz
#- 19: 250 kHz

#- Find nearest higher freq:
epicsEnvSet(TEMP_DONE,"")
ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>5000")
${IF_TRUE}epicsEnvSet(TEMP_FREQ,0) # Set to 10MHz
${IF_TRUE} # Setting freq to 10MHz
${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
ecmcEndIf()
${TEMP_DONE}ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>3330")
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_FREQ,1)
${TEMP_DONE}${IF_TRUE} # Setting freq to 5MHz
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
${TEMP_DONE}ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>2500")
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_FREQ,2)
${TEMP_DONE}${IF_TRUE} # Setting freq to 3.33MHz
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
${TEMP_DONE}ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>2000")
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_FREQ,3)
${TEMP_DONE}${IF_TRUE} # Setting freq to 2.5MHz
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
${TEMP_DONE}ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>1000")
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_FREQ,4 )
${TEMP_DONE}${IF_TRUE} # Setting freq to 2MHz
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
${TEMP_DONE}ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>500")
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_FREQ,9 )
${TEMP_DONE}${IF_TRUE} # Setting freq to 1MHz
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
${TEMP_DONE}ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>250")
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_FREQ,17 )
${TEMP_DONE}${IF_TRUE} # Setting freq to 500kHz
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
${TEMP_DONE}epicsEnvSet(TEMP_FREQ,19 )
${TEMP_DONE} # Setting freq to 250kHz
${TEMP_DONE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x13,${TEMP_FREQ=1}},1)"
epicsEnvUnset(CLK_FRQ_KHZ)
epicsEnvUnset(ENC_CLK_FRQ)
epicsEnvUnset(TEMP_FREQ)
epicsEnvUnset(TEMP_DONE)

#- 0x80p8:14: Coding
#- 0: Dual code active (default)
#- 1: Gray code active
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x14,${CODEING=${ENC_CODEING=0}},1)"

#- 0x80p8:15: Multiturn [Bit] Number of multiturn bits
#- default 12
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x15,${MT_BITS=${ENC_MT_BITS=0}},1)"
epicsEnvUnset(ENC_MT_BITS)

#- 0x80p8:16: Singleturn [Bit] Number of singleturn bits
#- default 13
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x16,${ST_BITS=${ENC_ST_BITS=0}},1)"
epicsEnvUnset(ENC_ST_BITS)

#- 0x80p8:17: Offset LSB Bit [Bit] Number of “right aligned” Offset bits
#- default 0
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x17,${OFF_BITS=${ENC_OFF_BITS=0}},1)"
epicsEnvUnset(ENC_OFF_BITS)

#- 0x80p8:18: Mode
#- 0: BiSS-C mode (default)
#- 1: SSI mode
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x18,${ENC_MODE=0},1)"
epicsEnvUnset(ENC_MODE)
