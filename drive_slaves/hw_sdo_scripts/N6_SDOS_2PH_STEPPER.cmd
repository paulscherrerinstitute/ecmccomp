#==============================================================================
# N6_SDOS_2PH_STEPPER.cmd
#-d /**
#-d   \brief Configure a Nanotec N6 for a generic two-phase stepper
#-d   \details Uses the FIR-v2508 N6 EtherCAT object dictionary
#-d   \file
#-d */

#- The N6 has one motor channel.
ecmcEpicsEnvSetCalcTernary(DIE,"${CH_ID=1}=1","#-","")
${DIE}ecmcExit Error: N6 only supports CH_ID=1
epicsEnvUnset(DIE)

#- Open-loop stepper: 0x3202 bit 6=0 selects stepper, bit 0=0 selects OL.
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x3202,0x00,0,4)"

#- Full-step count to electrical pole pairs: 1.8 deg/200 steps -> 50 pairs.
ecmcEpicsEnvSetCalc(N6_POLE_PAIRS,"${STEPS=${MOT_STEPS=200}}/4","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x2030,0x00,${N6_POLE_PAIRS},2)"
epicsEnvUnset(N6_POLE_PAIRS)

#- Rated phase current in mA. Limit it to 1000 per-mille of that rating.
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x6075,0x00,${I_MAX_MA_VALID},4)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x6073,0x00,1000,2)"

#- Initial I2t maximum-current duration. Nanotec recommends 100 ms for first
#- commissioning; applications may override and validate it afterwards.
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x3219,0x01,${I2T_MAX_MS=100},2)"

#- Open-loop current reduction after standstill. 0x3219:03 is per-mille of
#- rated current, not an absolute current value.
ecmcEpicsEnvSetCalc(N6_STDBY_PPK,"${I_STDBY_MA_VALID}/${I_MAX_MA_VALID}*1000","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x3219,0x02,${CURR_RED_DLY_MS=1000},2)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x3219,0x03,${N6_STDBY_PPK},2)"
epicsEnvUnset(N6_STDBY_PPK)

#- Invert both position and velocity polarity together when requested.
ecmcEpicsEnvSetCalc(N6_POLARITY,"${INV_DIR=0}*192","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x607E,0x00,${N6_POLARITY},1)"
epicsEnvUnset(N6_POLARITY)

#- CSV and its 1 ms interpolation period. The N6 requires a 1 ms sync signal.
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x6060,0x00,9,1)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x60C2,0x01,1,1)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x60C2,0x02,253,1)"

#- Native high-resolution units. Component macros can override the hardware
#- configuration defaults; these writes are queued later and therefore win.
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x60A8,0x00,${N6_POS_UNIT=0x00B50000},4)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x60A9,0x00,${N6_VEL_UNIT=0x00B50300},4)"

ecmcConfig "Cfg.EcSetSlaveSDOSettingsDone(${COMP_S_ID},${CH_ID=1},${CH_ID=1},1)"

epicsEnvUnset(STEPS)
epicsEnvUnset(I2T_MAX_MS)
epicsEnvUnset(CURR_RED_DLY_MS)
epicsEnvUnset(N6_POS_UNIT)
epicsEnvUnset(N6_VEL_UNIT)
