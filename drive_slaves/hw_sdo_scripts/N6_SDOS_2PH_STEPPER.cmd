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

#- PositionOutput must follow the motor; otherwise this motor's units would
#- silently change the interval of an already configured output.
ecmcEpicsEnvSetCalcTernary(DIE,"'${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_POS_UNIT=}'!=''","","#-")
${DIE}ecmcExit Error: Apply the N6 motor before the PositionOutput component
epicsEnvUnset(DIE)

#- Electrical selectors are booleans, independent of the motor-current validation.
#- Reject invalid settings before queuing any SDOs.
ecmcEpicsEnvSetCalcTernary(N6_MOTOR_BAD_IO,"'${N6_IO_24V=1}'!='0' and '${N6_IO_24V=1}'!='1'","","#-")
${N6_MOTOR_BAD_IO}ecmcExit Error: N6_IO_24V must be 0 (5 V) or 1 (24 V/+UB_Logic)
ecmcEpicsEnvSetCalcTernary(N6_MOTOR_BAD_IO,"'${N6_INPUT_PULLUP=0}'!='0' and '${N6_INPUT_PULLUP=0}'!='1'","","#-")
${N6_MOTOR_BAD_IO}ecmcExit Error: N6_INPUT_PULLUP must be 0 (pull-down) or 1 (pull-up)
epicsEnvUnset(N6_MOTOR_BAD_IO)

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

#- Digital I/O electrical configuration. The voltage selector is shared:
#- 1 selects 24 V input thresholds and +UB output levels; 0 selects 5 V.
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x323A,0x01,${N6_IO_24V=1},1)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x323A,0x02,${N6_INPUT_PULLUP=0},1)"

ecmcConfig "Cfg.EcSetSlaveSDOSettingsDone(${COMP_S_ID},${CH_ID=1},1)"

#- Per-master/slave capabilities for the optional position-output component.
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_MOTOR_APPLIED,1)
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_INV_DIR,${INV_DIR=0})
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_IO_24V,${N6_IO_24V=1})
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_INPUT_PULLUP,${N6_INPUT_PULLUP=0})

epicsEnvUnset(STEPS)
epicsEnvUnset(I2T_MAX_MS)
epicsEnvUnset(CURR_RED_DLY_MS)
epicsEnvUnset(N6_POS_UNIT)
epicsEnvUnset(N6_VEL_UNIT)
epicsEnvUnset(N6_IO_24V)
epicsEnvUnset(N6_INPUT_PULLUP)
