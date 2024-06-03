#==============================================================================
# Festo-CMMT-ST_SDOS_2PH_STEPPER.cmd
#-d /**
#-d   \brief SDOS for Festo-CMMT-ST drive for 2Ph stepepr
#-d   \details Parametrization of Festo-CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d */


#- =========== Resistance ============
ecmcEpicsEnvSetCalcTernary(DIE,"${R_COIL_MOHM=${MOT_R_COIL_MOHM}} < 0","", "#-")
${DIE}ecmcExit Error: Coil resistance invalid

#- =========== Inductance ============
ecmcEpicsEnvSetCalcTernary(DIE,"${L_COIL_UH=${MOT_L_COIL_UH}} < 0","", "#-")
${DIE}ecmcExit Error: Coil inductance invalid.

#- Run current [A]
ecmcEpicsEnvSetCalc(FESTO_TEMP_CURR,"${I_MAX_MA_VALID}/1000","%lf")
#- Rated [A]
#-  0x216c:04, rwrwrw, float, 32 bit, "P1.7117.0.0_iRated"
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x4,${FESTO_TEMP_CURR},F32)"
#- Max [A]
#-  0x216c:05, rwrwrw, float, 32 bit, "P1.7120.0.0_iMax"
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x5,${FESTO_TEMP_CURR},F32)"

#- Stanby current [A]
#-  0x216c:14, rwrwrw, float, 32 bit, "P1.71424.0.0_continuousStandstillCurrentRated"
ecmcEpicsEnvSetCalc(FESTO_TEMP_CURR_STDBY,"${I_STDBY_MA_VALID} / 1000","%lf")
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x14,${FESTO_TEMP_CURR_STDBY},F32)"

#- P0.1209.0.0 mains voltage float
ecmcEpicsEnvSetCalc(FESTO_TEMP_NOM_V,"${U_NOM_MV_VALID} / 1000","%lf")
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2288,0x1,${FESTO_TEMP_NOM_V},F32)"
epicsEnvUnset(FESTO_TEMP_NOM_V)

#- =========== Open loop settings ============
#- Open-loop operation objects
#- Parameter Index.Subindex Name Data type
#- 270 0x219C.02 Setpoint value reactive current REAL
#- 662 0x219C.03 Time current increase REAL
#- 4001 0x219C.04 Activation of open loop operation BOOL
#- 4004 0x219C.07 Active control structure UDINT
#- 4005 0x219C.08 Selection of mode of operation open loop/
#- closed loop
#- UDINT
#- 4006 0x219C.09 Selection of mode of operation UDINT
#- 4007 0x219C.0A Active mode of operation UDINT
#- 4008 0x219C.0B Velocity switching threshold REAL
#- 4010 0x219C.0D Current rise time REAL
#- 4026 0x219C.15 Current reduction activation BOOL
#- 4027 0x219C.16 Current reduction delay time REAL
#- 4028 0x219C.17 Current reduction scaling factor REAL
#- 6694 0x219C.14 Factor current setpoint value REAL

#- Run current [A]
#-  0x219c:02, rwrwrw, float, 32 bit, "P1.270.0.1"
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x2,${FESTO_TEMP_CURR},F32)"

#- Current reduction scaling factor []
#-  0x219c:17, rwrwrw, float, 32 bit, "P1.4028.0.0"
ecmcEpicsEnvSetCalc(FESTO_TEMP_CURR_SCALE,"${FESTO_TEMP_CURR_STDBY}/${FESTO_TEMP_CURR}","%lf")
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x17,${FESTO_TEMP_CURR_SCALE},F32)"

#- Current reduction delay time [s]
#-  0x216c:01, rwrwrw, uint32, 32 bit, "P1.4027.0.0"
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x16,${CURR_RED_DLY_S=0.5},F32)"
epicsEnvUnset(CURR_RED_DLY_S)

#- Selection open closed loop P1.4005.0.0
#- Automatic = 0
#- Open loop = 1 default
#- Closed loop = 2
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x8,${CTRL_MODE=1},U32)"

#- Set default to open loop P1.4006.0.0
#- Automatic = 0
#- Open loop = 1 default
#- Closed loop = 2
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x9,${CTRL_MODE=1},U32)"

#- Activation of open loop [] P1.4001.0.0
#- 4001 0x219C.04 Activation of open loop operation BOOL
ecmcIf("${CTRL_MODE=1}==1")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x4,1,U8)"
#- else
${IF_FALSE}ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x4,0,U8)"
ecmcEndIf()
epicsEnvUnset(CTRL_MODE)

#- Velocity threshold (Open loop-> closed loop)
#-P1.4008.0.0
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0xB,${VELO_SWITCH_LIM=0.0},F32)"
epicsEnvUnset(VELO_SWITCH_LIM)

#- Disable commutation [] Set to off for open loop stepper P1.668.0.0
#-P1.668.0.0
#- 0 = Always
#- 1 = Automatic
#- 2 = Off
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216B,0x6,${COMMUTATION=2},U32)"
epicsEnvUnset(COMMUTATION)

#- Max RPM p1.7123.0.0
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x6,${MAX_RPM=4000},F32)"
epicsEnvUnset(MAX_RPM)

#- Nominal RPM p1.7126.0.0
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x7,${NOM_RPM=4000},F32)"
epicsEnvUnset(NOM_RPM)

#- User defined run current
#-  0x216c:14, rwrwrw, float, 32 bit,
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x14,${FESTO_TEMP_CURR},F32)"

#- =========== Open loop settings end ============

epicsEnvUnset(FESTO_TEMP_CURR)
epicsEnvUnset(FESTO_TEMP_CURR_STDBY)
epicsEnvUnset(FESTO_TEMP_CURR_SCALE)

#- Pole pairs []
#-  0x216c:01, rwrwrw, uint32, 32 bit, "P1.718.0.0_numberPolePairs"
ecmcEpicsEnvSetCalc(FESTO_TEMP,"${STEPS=${MOT_STEPS=200}} / 4","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x216C,0x1,${FESTO_TEMP=50},4)"

#- Rotor inertia [kgm²]
#-  0x216c:02, rwrwrw, float, 32 bit, "P1.7111.0.0_rotorInertia"
ecmcEpicsEnvSetCalc(FESTO_TEMP,"${ROT_INERTIA_GCM2=${MOT_ROT_INERTIA_GCM2=0}} / 1e7","%lf")
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x2,${FESTO_TEMP=0.0},F32)"
epicsEnvUnset(FESTO_TEMP)

#- Motor type [] (1=stepper,2=servo), set to stepper
#-  0x216c:17, rwrwrw, uint8, 8 bit, "P1.71432.0.0_motorType"
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x17,1,U8)"

#- Inductance [H]
#-  0x216c:08, rwrwrw, float, 32 bit, "P1.7129.0.0_windingInductance"
ecmcEpicsEnvSetCalc(FESTO_TEMP,"${L_COIL_UH=${MOT_L_COIL_UH}} / 1e6","%lf")
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x8,${FESTO_TEMP=0.0},F32)"

#- Resistance [Ohm]
#-  0x216c:09, rwrwrw, float, 32 bit, "P1.7132.0.0_windingResistance"
ecmcEpicsEnvSetCalc(FESTO_TEMP,"${R_COIL_MOHM=${MOT_R_COIL_MOHM}} / 1000","%lf")
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x9,${FESTO_TEMP=0.0},F32)"

#- Torque constant [Nm/Arms]
#-  0x216c:0a, rwrwrw, float, 32 bit, "P1.7135.0.0_km"
#- First calculate based on MOT_TRQ_CONST_MNM_P_A
ecmcEpicsEnvSetCalc(FESTO_TEMP_1,"${TRQ_CONST_MNM_P_A=${MOT_TRQ_CONST_MNM_P_A=-1}} / 1000","%lf")
#- Calculate based on I_MAX_MA_VALID and MOT_TRQ_MAX_NMM
ecmcEpicsEnvSetCalc(FESTO_TEMP_2,"(${MOT_TRQ_MAX_NMM=-1}/1000)/(${I_MAX_MA_VALID}/1000)","%lf")

ecmcIf("${FESTO_TEMP_1}>0")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x0a,${FESTO_TEMP_1=0.0},F32)"
${IF_TRUE}epicsEnvSet(FESTO_DONE)
ecmcEndIf()

ecmcIf("${FESTO_TEMP_2}>0 and not(${FESTO_DONE=0})")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x0a,${FESTO_TEMP_2=0.0},F32)"
${IF_TRUE}# WARNING: Setting motor constant based on MOT_TRQ_MAX_NMM and I_MAX_MA_VALID
${IF_TRUE}epicsEnvSet(FESTO_DONE)
ecmcEndIf()

ecmcIf("not(${FESTO_DONE=0})")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x0a,0.0,F32)"
${IF_TRUE} # WARNING motor torque constant not set
ecmcEndIf()

#- Voltage [V]
#-  0x216c:13, rwrwrw, float, 32 bit, "P1.71421.0.0_voltageRated"
ecmcEpicsEnvSetCalc(FESTO_TEMP,"${U_NOM_MV_VALID} / 1000","%lf")
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x13,${FESTO_TEMP=0.0},F32)"

#- Pole pair denominator set to 1 for stepper
#-  0x216c:18, rwrwrw, uint32, 32 bit, "P1.7185.0.0_numberPolePairsDenom"
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x18,1,U16)"

#-         #- Set diag level following error to info:
#-         ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2166,0x17,2,U16)"
#-         
#-         #- Set diag level following error to info: "P1.4622.0.0"
#-         #- ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2166,0x23,2,U16)"
#-         
#-         #- Set diag level following error velo to ignore:
#-         ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2166,0x19,2,U16)"
#-         
#-         #- Set diag level following error velo to ignore:  "P1.4624.0.0"
#-         #- ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2166,0x25,2,U16)"
#-         
#-         #- Set diag level for max velo monitoring
#-         ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2166,0x31,2,U16)"
#-         
#-         #- Set diag level for max velo monitoring: "P1.4661.0.0"
#-         #-ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2166,0x49,2,U16)"

#- Allow enable over fieldbus/ethercat P1.1023.0.0
#- 2 = Only fieldbus 
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x218E,0x2,2,U32)"

#- Set startup mode after enable p0.10234.0.0
#- 4 = velocity  (default)
#- 5 = position
#- 7 = torque

ecmcIf("'${CSX_MODE=CSV}'=='CSV'")
${IF_TRUE}epicsEnvSet(FESTO_TEMP_CSX,4)
ecmcEndIf()
ecmcIf("'${CSX_MODE=CSV}'=='CSP'")
${IF_TRUE}epicsEnvSet(FESTO_TEMP_CSX,5)
ecmcEndIf()
ecmcIf("'${CSX_MODE=CSV}'=='CST'")
${IF_TRUE}epicsEnvSet(FESTO_TEMP_CSX,7)
ecmcEndIf()

ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x218E,0x3,${FESTO_TEMP_CSX=4},U32)"
epicsEnvUnset(CSX_MODE)
epicsEnvUnset(FESTO_TEMP_CSX)

#-#- Seems not needed
#-#- CiA402 Position unit
#-#- P1.7851.0.0, 0x216E.1
#-#- 16640 = Degree
#-ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216E,0x1,${CIA402_POS=16640},U16)"
#-epicsEnvUnset(CIA402_POS)
#-
#-#- CiA402 Velocity unit
#-#- P1.7852.0.0, 0x216E.2
#-#- 16643 = Degree/s
#-ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216E,0x2,${CIA402_VEL=16643},U16)"
#-epicsEnvUnset(CIA402_VEL)
#-
#-#- CiA402 Acceleration unit
#-#- P1.7853.0.0, 0x216E.3
#-#- 16727 = Degree/s/s
#-ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216E,0x3,${CIA402_ACC=16727},U16)"
#-epicsEnvUnset(CIA402_VEL)
#-
#-#- CiA402 Jerk unit
#-#- P1.7854.0.0, 0x216E.4
#-#- 16800 = Degree/s/s/s
#-ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216E,0x4,${CIA402_JERK=16800},U16)"
#-epicsEnvUnset(CIA402_JERK)

#- CiA402 Selction of next user units
#- P1.1151.0.0, 0x217c:2
#- 0 : Internal increments inc/s ..
#- 1 : Increments inc/s ..  (default in ecmccomp)
#- 2 : Rev, rev/s
#- 3 : Rev, rev/min
#- 4 : Rad, rad/s
#- 5 : Deg, deg/s
#- 6 : Metric m m/s
#- 7 : Imperial in in/s
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x217C,0x2,${CIA402_UNIT=1},U32)"
epicsEnvUnset(CIA402_UNIT) 

 
#- Set drive configured bit! P1.1207.0.0, 0x217F:8dec
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x217F,0x8,1,U8)"

#- BO1 Set outputs to useable from EPCIS. P0.11203.0.0
#- Can be set to 38 different things.. see docs
#ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x212F,0xC,37,U32)"

#- BO2 Set outputs to useable from EPCIS. P0.11204.0.0
#- Can be set to 38 different things.. see docs
#ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x212F,0xD,38,U32)"

#- BO bit mask p1.1128055.0.0 This makes the go into Motion task error state..
#- ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x60FE,0x2,196609,U32)"

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

#-SDO 0x216c, "MotorDeviceInformationUserConfiguration"
#-  0x216c:00, r-r-r-, uint8, 8 bit, "SubIndex 000"
#-  0x216c:01, rwrwrw, uint32, 32 bit, "P1.718.0.0_numberPolePairs" X
#-  0x216c:02, rwrwrw, float, 32 bit, "P1.7111.0.0_rotorInertia" X
#-  0x216c:03, rwrwrw, uint8, 8 bit, "P1.7114.0.0_isCounterClockwisePhaseSequence"
#-  0x216c:04, rwrwrw, float, 32 bit, "P1.7117.0.0_iRated" X 
#-  0x216c:05, rwrwrw, float, 32 bit, "P1.7120.0.0_iMax" X
#-  0x216c:06, rwrwrw, float, 32 bit, "P1.7123.0.0_vMax"
#-  0x216c:07, rwrwrw, float, 32 bit, "P1.7126.0.0_vRated"
#-  0x216c:08, rwrwrw, float, 32 bit, "P1.7129.0.0_windingInductance" X
#-  0x216c:09, rwrwrw, float, 32 bit, "P1.7132.0.0_windingResistance" X
#-  0x216c:0a, rwrwrw, float, 32 bit, "P1.7135.0.0_km" X
#-  0x216c:0b, rwrwrw, float, 32 bit, "P1.7144.0.0_i2tTime"
#-  0x216c:0c, rwrwrw, float, 32 bit, "P1.7147.0.0_maximumWindingTemperature"
#-  0x216c:0d, rwrwrw, uint32, 32 bit, "P1.7153.0.0_sensorType" X Not used
#-  0x216c:0e, rwrwrw, uint8, 8 bit, "P1.7159.0.0_isBrakeAvailable"
#-  0x216c:0f, rwrwrw, float, 32 bit, "P1.7162.0.0_brakeTurnOnDelay"
#-  0x216c:10, rwrwrw, float, 32 bit, "P1.7165.0.0_brakeTurnOffDelay"
#-  0x216c:11, rwrwrw, string, 256 bit, "P1.7182.0.0_nocCodeMotor" X Not used
#-  0x216c:12, rwrwrw, uint32, 32 bit, "P1.7184.0.0_motorDatabaseId" X Not used
#-  0x216c:13, rwrwrw, float, 32 bit, "P1.71421.0.0_voltageRated" X
#-  0x216c:14, rwrwrw, float, 32 bit, "P1.71424.0.0_continuousStandstillCurrentRated" X
#-  0x216c:15, rwrwrw, float, 32 bit, "P1.71430.0.0_qAxisInductance" X Not used (0 for stepper)
#-  0x216c:16, rwrwrw, float, 32 bit, "P1.71431.0.0_dAxisInductance" X Not used (0 for stepper)
#-  0x216c:17, rwrwrw, uint8, 8 bit, "P1.71432.0.0_motorType" X
