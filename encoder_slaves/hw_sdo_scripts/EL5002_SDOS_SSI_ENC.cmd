#==============================================================================
# EL5002_SDOS_SSI_ENC.cmd
#-d /**
#-d   \brief SDOS for EL5002 encoder interface
#-d   \details Parametrization of EL5002
#-d   \author Anders Sandström
#-d   \file
#-d */  

#- Calculate SDO adress based on CH (0x8000 for CH1, 0x8010 for CH2)
ecmcEpicsEnvSetCalc(CH_ID_M1,"${CH_ID=1}-1")
epicsEnvSet(SDO_INDEX,"0x80${CH_ID_M1}0")
epicsEnvUnset(CH_ID_M1)

#- Supress frame error (default setting)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},${SDO_INDEX},${DIS_STAT_BITS=${ENC_DIS_STAT_BITS=0}},0,1)"
epicsEnvUnset(DIS_STAT_BITS)

#- Disable power failure bit  (default setting)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},${SDO_INDEX},0x2,${ENA_POW_STAT_BIT=${ENC_ENA_POW_STAT_BIT=0}},1)"
epicsEnvUnset(ENA_POW_BIT)

#- Disable inhibit bit  (default setting)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},${SDO_INDEX},0x3,0,1)"

#- Disable test mode  (default setting)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},${SDO_INDEX},0x4,0,1)"

#- Coding
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},${SDO_INDEX},0x6,${CODING=${ENC_CODING}},1)"
epicsEnvUnset(CODING)

#- 0x80p8:9: Clock Frequency
#- 1: 1.25 MHz
#- 2: 1 MHz (Max for SSI)
#- 3: 500 kHz
#- 4: 250 kHz
#- 5: 125 kHz
#- Find nearest higher freq:
epicsEnvSet(TEMP_DONE,"")
ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>1000")
${IF_TRUE}epicsEnvSet(TEMP_FREQ,1) # Set to 1250kHz
${IF_TRUE} # Setting freq to 10MHz
${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
ecmcEndIf()
${TEMP_DONE}ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>500")
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_FREQ,2)
${TEMP_DONE}${IF_TRUE} # Setting freq to 1MHz
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
${TEMP_DONE}ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>250")
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_FREQ,3)
${TEMP_DONE}${IF_TRUE} # Setting freq to 500kHz
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
${TEMP_DONE}ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>125")
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_FREQ,4)
${TEMP_DONE}${IF_TRUE} # Setting freq to 250kHz
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
${TEMP_DONE}epicsEnvSet(TEMP_FREQ,5 )
${TEMP_DONE} # Setting freq to 125kHz
${TEMP_DONE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_INDEX},0x9,${TEMP_FREQ=3},1)"
epicsEnvUnset(CLK_FRQ_KHZ)
epicsEnvUnset(ENC_CLK_FRQ_KHZ)
epicsEnvUnset(TEMP_FREQ)
epicsEnvUnset(TEMP_DONE)

#- SSI frame type variable analysis =2 (default setting)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},${SDO_INDEX},0xF,2,1)"

#- SSI frame size 26bits
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},${SDO_INDEX},0x11,${FRM_SIZE=${ENC_FRM_SIZE}},2)"

#- SSI data length 25bits
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},${SDO_INDEX},0x12,${ST_BITS=${ENC_ST_BITS}},2)"
