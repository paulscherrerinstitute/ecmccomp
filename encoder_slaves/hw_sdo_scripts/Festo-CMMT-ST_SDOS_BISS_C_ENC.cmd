#==============================================================================
# Festo-CMMT-ST_SDOS_BISS_C_ENC.cmd
#-d /**
#-d   \brief SDOS for Festo CMMT-ST BISS-C interface
#-d   \details Parametrization of Festo CMMT-ST BISS C
#-d   \author Anders Sandström
#-d   \file
#-d */  

#- 0x226E:01: Invert direction (default 0)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x226E,0x1,${INV_DIR=0},1)"
epicsEnvUnset(INV_DIR)

#- 0x2230:125: Select BISS-C encoder
#- 4: Incremental encoder
#- 7: Without encoder
#- 8: BISS-C (choose BISS)
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2130,0x7D,8,S32)"

#- Singleturn bits
#- 0x21A2:01: Single turn bits (max 32)
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x21A2,0x1,${ST_BITS=${ENC_ST_BITS=100}},U32)"
epicsEnvUnset(ST_BITS)

#- Multiturn bits
#- 0x21A2:02: Multi turn bits (max 32), set default to invalid
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x21A2,0x2,${MT_BITS=${ENC_MT_BITS=100}},U32)"
epicsEnvUnset(MT_BITS)

# Activation of correction table P0.3613.0.0
#- 0x21A2:13, Deactivate per default
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x21A2,0xD,${ACTIVATE_CORR=0},U8)"
epicsEnvUnset(ACTIVATE_CORR)

# Encoder homed P0.2337.0.0
#- 0x2130:63, Set to homed per default
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2130,0x3F,${HOMED=1},U8)"
epicsEnvUnset(HOMED)

#- Clock rate
#- 0x21A2:0C: P0.3612.0 clock rate [Hz]
#- Supported:
#- 1.5MHz : default
#- 3MHz   : 
#- 6MHz   : 
#- 12MHz  : 

#- Try to find the closest rate:
epicsEnvSet(TEMP_DONE,"")
ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>6000")
${IF_TRUE}epicsEnvSet(TEMP_FREQ,12000000) # Set to 12MHz
${IF_TRUE} # Setting freq to 12MHz
${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
ecmcEndIf()
${TEMP_DONE}ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>3000")
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_FREQ,6000000)
${TEMP_DONE}${IF_TRUE} # Setting freq to 6MHz
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
${TEMP_DONE}ecmcIf("${CLK_FRQ_KHZ=${ENC_CLK_FRQ_KHZ}}>1500")
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_FREQ,3000000)
${TEMP_DONE}${IF_TRUE} # Setting freq to 3MHz
${TEMP_DONE}${IF_TRUE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()
${TEMP_DONE}epicsEnvSet(TEMP_FREQ,1500000 )
${TEMP_DONE} # Setting freq to 1.5MHz
${TEMP_DONE}epicsEnvSet(TEMP_DONE,"#-")
${TEMP_DONE}ecmcEndIf()

ecmcIf("${FORCE_CLK_FRQ_HZ=${TEMP_FREQ=6000000}}!=6000000")
${IF_TRUE}ecmcExit() : Error: Invalid BISS-C clock-rate. Festo CMMT-ST only supports 6MHz BISS-C clock-rate. Use Macro 'CLK_FRQ_KHZ=6000' to override the setting in encoder file.
ecmcEndIf()

ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x21A2,0x0c,${FORCE_CLK_FRQ_HZ=${TEMP_FREQ=6000000}},U32)"
epicsEnvUnset(CLK_FRQ_KHZ)
epicsEnvUnset(ENC_CLK_FRQ_KHZ)
epicsEnvUnset(TEMP_FREQ)
epicsEnvUnset(TEMP_DONE)
epicsEnvUnset(FORCE_CLK_FRQ_HZ)

#- ########### MUST BE LAST ##############
#- Reinit drive (seems it needs to be like this..)
ecmcConfigOrDie "Cfg.EcWriteSdo(${COMP_S_ID},0x2003,0x1,1,1)"
epicsThreadSleep 0.1
ecmcConfigOrDie "Cfg.EcWriteSdo(${COMP_S_ID},0x2003,0x1,0,1)"
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2003,0x1,1,S8)"

epicsEnvUnset(FESTO_TEMP_2)
epicsEnvUnset(FESTO_TEMP_1)
epicsEnvUnset(FESTO_TEMP)
epicsEnvUnset(FESTO_DONE)
