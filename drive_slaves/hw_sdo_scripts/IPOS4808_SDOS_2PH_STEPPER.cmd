#==============================================================================
# IPOS4808_2PH_STEPPER.cmd
#-d /**
#-d   \brief SDOS for IPOS4808 drive
#-d   \details Parametrization of IPOS4808
#-d   \author Anders Sandström
#-d   \file
#-d   macros: I_MAX_MA,I_STDBY_MA,I_CTRL_GAIN,I_CTRL_INT
#-d */
#-d

# Check mandatory macros:
#- I_CTRL_GAIN:
ecmcEpicsEnvSetCalcTernary(DIE,"'${I_CTRL_GAIN=NAN}'=='NAN'","", "#-")
${DIE}ecmcExit Error: I_CTRL_GAIN is a mandatory macro for iPOS4808

#-I_CTRL_INT:
ecmcEpicsEnvSetCalcTernary(DIE,"'${I_CTRL_INT=NAN}'=='NAN'","", "#-")
${DIE}ecmcExit Error: I_CTRL_INT is a mandatory macro for iPOS4808
epicsEnvUnset(DIE)

#- Set the basics like step-resolution steps per turn and more...
ecmcFileExist(${ecmccomp_DIR}IPOSXXXX_SDOS_2PH_STEPPER_generic.cmd,1,1)
${SCRIPTEXEC} ${ecmccomp_DIR}IPOSXXXX_SDOS_2PH_STEPPER_generic.cmd

#- ###########################################################
#- ############ Configure settings not directly accessible as sdos:
#-  Use 0x2064, 0x2067 for drive memory access, see technosoft CoE manual.
#-
#-  Configuration word to next write
#-  Bit 31..16: Address=0x271  (example KPI)
#-  Bit 15..8: Always 0
#-  Bit 7: 1 (Do not auto increment)
#-  Bit 6..4 Always 0
#-  Bit 3,2: 01 (DATA)
#-  Bit 1: Always 0
#-  Bit 0: 0 (16bit)
#-  Result: 0x2710084
epicsEnvSet("ECMC_TECHNOSOFT_CFG_HEX"          "0084")

#- ############ Current controller:
#-  The values for current control can be automatically tuned/calculated in EasymotionStudio.
#-  KPI at technosoft address 0x0271 range 0..32737 (int). TML Command in Technosoft EasyMotionStudio "Command Interpreter": ?KPI
#-  SFTKPI at technosoft address 0x0272 range 0..14 (int). TML Command in Technosoft EasyMotionStudio "Command Interpreter": ?SFTKPI
#-  Formula Kp=KPI/32767*2^SFTKPI

#- How many divisions with 2 is needed to get below 1
#- x=log(ECMC_KPI_TEMP)/log(2)
#-ecmcEpicsEnvSetCalc(ECMC_SFTKPI,"trunc(log(${I_CTRL_GAIN})/log(2))+1;","%d")
#-ecmcEpicsEnvSetCalcTernary(ECMC_SFTKPI,"${ECMC_SFTKPI} < 0","0", "${ECMC_SFTKPI}")
#-ecmcEpicsEnvSetCalc(ECMC_KPI,"${I_CTRL_GAIN=0.83}*32767/pow(2,${ECMC_SFTKPI});","%d")
#-ecmcEpicsEnvSetCalc(ECMC_KPI_HEX,"${ECMC_KPI};","%04x")
#-ecmcEpicsEnvSetCalc(ECMC_SFTKPI_HEX,"${ECMC_SFTKPI};","%04x")
#-epicsEnvShow(ECMC_KPI)
#-epicsEnvShow(ECMC_KPI_HEX)
#-epicsEnvShow(ECMC_SFTKPI)
#-epicsEnvShow(ECMC_SFTKPI_HEX)

ecmcFileExist(${ecmccomp_DIR}IPOSXXXX_recalc_data_log_format.cmd,1,1)
${SCRIPTEXEC} ${ecmccomp_DIR}IPOSXXXX_recalc_data_log_format.cmd "IN_VAL=${CURR_KP}"

#-  Write data KPI in hex
epicsEnvSet("ECMC_TECHNOSOFT_ADR_HEX"          "0271")
epicsEnvSet("ECMC_TECHNOSOFT_DATA_HEX"         "${IPOS_OUT_VAL}")
${SCRIPTEXEC} ${ecmccfg_DIR}technosoftWriteGenericCfg.cmd

#-  Write data SFTKPI=0x0(0dec)
epicsEnvSet("ECMC_TECHNOSOFT_ADR_HEX"          "0272")
epicsEnvSet("ECMC_TECHNOSOFT_DATA_HEX"         "${IPOS_OUT_EXP}")
${SCRIPTEXEC} ${ecmccfg_DIR}technosoftWriteGenericCfg.cmd

#-  KII at technosoft address 0x0273 range 0..32737 (int). TML Command in Technosoft EasyMotionStudio "Command Interpreter": ?KII
#-  SFTKII at technosoft address 0x0274 range 0..14 (int). TML Command in Technosoft EasyMotionStudio "Command Interpreter": ?SFTKII
#-  Formula Ki=KII/32767*2^SFTKII
${SCRIPTEXEC} ${ecmccomp_DIR}IPOSXXXX_recalc_data_log_format.cmd "IN_VAL=${CURR_TI}"

#-  Write data KII=216b (8555)
epicsEnvSet("ECMC_TECHNOSOFT_ADR_HEX"          "0273")
epicsEnvSet("ECMC_TECHNOSOFT_DATA_HEX"         "${IPOS_OUT_VAL}")
${SCRIPTEXEC} ${ecmccfg_DIR}technosoftWriteGenericCfg.cmd

#-  Write data SFTKII=0x0 (0dec)
epicsEnvSet("ECMC_TECHNOSOFT_ADR_HEX"          "0274")
epicsEnvSet("ECMC_TECHNOSOFT_DATA_HEX"         "${IPOS_OUT_EXP}")
${SCRIPTEXEC} ${ecmccfg_DIR}technosoftWriteGenericCfg.cmd

epicsEnvUnset(IPOS_OUT_VAL)
epicsEnvUnset(IPOS_OUT_EXP)

#- ############ Max Current protection:
#-  IMAXPROT at technosoft address 0x0295
#-  IMAXPROT=Imax*1638 *1.5.. set current protect to 50% higher than MAX current... Might not work always if sett ing is higher than 20A/1.5
ecmcEpicsEnvSetCalc(IPOS_CURR_PROT,"${I_MAX_MA_VALID}*1.5*1638","%04x")

#-  Write data IMAXPROT=0x1CCB (7371dec)
epicsEnvSet("ECMC_TECHNOSOFT_ADR_HEX"          "0295")
epicsEnvSet("ECMC_TECHNOSOFT_DATA_HEX"         "${IPOS_CURR_PROT}")
${SCRIPTEXEC} ${ecmccfg_DIR}technosoftWriteGenericCfg.cmd
epicsEnvUnset(IPOS_CURR_PROT)

#- ############ Speed controller:
#-  KPS at technosoft address 0x0237 range 0..32737 (int)
#-  SFTKPS at technosoft address 0x0238 range 0..14 (int)
#-  Formula Kp=KPS/32767*2^SFTKPS
#-  NOT IMPLEMENTED since not needed yet

#-  KIS at technosoft address 0x0269 range 0..32737 (int)
#-  SFTKIS at technosoft address 0x026A range 0..14 (int)
#-  Formula Ki=KIS/32767*2^SFTKIS
#-  NOT IMPLEMENTED since not needed yet

#- ###########################################################
#- ############ Save changes and reset (NOTE: only needs to be executed if number of steps is changed above):
#- ${SCRIPTEXEC} ${ecmccfg_DIR}technosoftSaveAndReset.cmd

#- ###########################################################
#- ############ Configure SDOS:

#-  NOTE: SHOULD NOT BE USED. Already set above! Steps per rev 200poles, 256 levels of microstepping=>51200steps SHOULD NOT BE USED.
#- ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x2084,0x0,51200,4)"

#- Stepper current in open loop configuration 1A => 1638 (Isetting=2*Ipeak/65520*I, Ipeak=20A =>Isetting=1638*I)
ecmcEpicsEnvSetCalc(IPOS_CURR,"${I_MAX_MA_VALID}*1638/1000","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x2025,0x0,${IPOS_CURR},2)"
epicsEnvUnset(IPOS_CURR)

#- Stepper current in standby (open loop) 0.2A=>3281638 (Isetting=2*Ipeak/65520*I, Ipeak=20A =>Isetting=1638*I)
ecmcEpicsEnvSetCalc(IPOS_CURR,"${I_STDBY_MA_VALID}*1638/1000","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x2026,0x0,${IPOS_CURR},2)"
epicsEnvUnset(IPOS_CURR)
