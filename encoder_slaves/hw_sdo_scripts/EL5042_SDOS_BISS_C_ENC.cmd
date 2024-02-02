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
epicsEnvUnset(INV_DIR)

#- 0x80p8:02: Disable Status Bits (default 0)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x2,${DIS_STAT_BITS=${ENC_DIS_STAT_BITS=0}},1)"
epicsEnvUnset(DIS_STAT_BITS)

#- 0x80p8:03: CRC Invert (default 1 ?)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x3,${CRC_INV=${ENC_CRC_INV=1}},1)"
epicsEnvUnset(CRC_INV)

#- 0x80p8:11: CRC Polynom (default 67)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x11,${CRC_POLY=${ENC_CRC_POLY=67}},4)"
epicsEnvUnset(CRC_POLY)

#- 0x80p8:12: Supply voltage
#- 50: 5V (default)
#- 90: 9V
#- SETTINGS 9V is not supported right now because of the below from beckhoff manual (AFFECTS _BOTH_ channels):
#- Setting the encoder supply voltage
#-    Condition: To write 0x8008:12 “Supply Voltage”, the value 0x72657375 (ASCII: “user”) must be set in 0xF008 “Code word”.
#-
#-    Set the value into index 0x8008:12 “Supply Voltage” (Specification in steps of 0.1 V).
#-    Only the values 50 (5.0 V) and 90 (9.0 V) are permissible.
#-    This setting applies to both channels.
#-    Before switching to 9.0 V make sure that both BiSS encoders support the extended voltage range!
#-
#-    The encoder supply voltage is set for both channels in object 0x8008:12!
#-
#- BLOCK THIS CODE FOR NOW:
#- ecmcEpicsEnvSetCalc(U_SUP_VLT_MV_TEMP,"${U_SUP_VLT_MV=${ENC_U_SUP_VLT_MV=5000}} / 100","%d")
#- ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x12,${U_SUP_VLT_MV_TEMP=50},1)"
#- epicsEnvUnset(ENC_U_SUP_VLT_MV)
#- epicsEnvUnset(U_SUP_VLT_MV_TEMP)

#- Issue error if try to change voltage
ecmcIf("${U_SUP_VLT_MV=${ENC_U_SUP_VLT_MV=5000}}>5000")
${IF_TRUE}# ERROR: Supply voltage cannot be changed for EL5042 terminal by ecmccomp since the setting applies to _BOTH_ channels.
${IF_TRUE}#  To change the voltage you need to add "ecmcConfigOrDie Cfg.EcAddSdo(...)" in your startup script according to below Beckhoff documentation:
${IF_TRUE}#  ----------------------------------------------------------------------------------------------------------------------------
${IF_TRUE}#     Setting the encoder supply voltage
${IF_TRUE}#        Condition: To write 0x8008:12 “Supply Voltage”, the value 0x72657375 (ASCII: “user”) must be set in 0xF008 “Code word”.
${IF_TRUE}#
${IF_TRUE}#        Set the value into index 0x8008:12 “Supply Voltage” (Specification in steps of 0.1 V).
${IF_TRUE}#        Only the values 50 (5.0 V) and 90 (9.0 V) are permissible.
${IF_TRUE}#        This setting applies to both channels.
${IF_TRUE}#        Before switching to 9.0 V make sure that both BiSS encoders support the extended voltage range!
${IF_TRUE}#
${IF_TRUE}#        The encoder supply voltage is set for both channels in object 0x8008:12
${IF_TRUE}#  ----------------------------------------------------------------------------------------------------------------------------
${IF_TRUE}ecmcExit
ecmcEndIf()

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
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x13,${TEMP_FREQ=1},1)"
epicsEnvUnset(CLK_FRQ_KHZ)
epicsEnvUnset(ENC_CLK_FRQ_KHZ)
epicsEnvUnset(TEMP_FREQ)
epicsEnvUnset(TEMP_DONE)

#- 0x80p8:14: Coding
#- 0: Dual code active (default)
#- 1: Gray code active
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x14,${CODING=${ENC_CODING=0}},1)"
epicsEnvUnset(CODING)

#- 0x80p8:15: Multiturn [Bit] Number of multiturn bits
#- default 12
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x15,${MT_BITS=${ENC_MT_BITS=0}},1)"
epicsEnvUnset(MT_BITS)

#- 0x80p8:16: Singleturn [Bit] Number of singleturn bits
#- default 13
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x16,${ST_BITS=${ENC_ST_BITS=0}},1)"
epicsEnvUnset(ST_BITS)

#- 0x80p8:17: Offset LSB Bit [Bit] Number of “right aligned” Offset bits
#- default 0
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x17,${OFF_BITS=${ENC_OFF_BITS=0}},1)"
epicsEnvUnset(OFF_BITS)

#- 0x80p8:18: Mode
#- 0: BiSS-C mode (default)
#- 1: SSI mode
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x18,${MODE=${ENC_MODE=0}},1)"
epicsEnvUnset(MODE)
