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
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x16,${CURR_RED_DLY_S=0.2},F32)"
epicsEnvUnset(CURR_RED_DLY_S)

#- Set default to open loop
#- Automatic = 0
#- Open loop = 1 default
#- Closed loop = 2
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x9,${CTRL_MODE=1},U32)"

#- Activation of open loop []
#- 4001 0x219C.04 Activation of open loop operation BOOL
ecmcIf("${CTRL_MODE=1}==1")
${IF_TRUE}ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x4,1,U8)"
#- else
${IF_FALSE}ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x4,0,U8)"
ecmcEndIf()
epicsEnvUnset(CTRL_MODE)

#- Disable commutation [] Set to off for open loop stepper
#-P1668.0.0
#- 0 = Always
#- 1 = Automatic
#- 2 = Off
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216B,0x6,2,U32)"

#- =========== Open loop settings end ============

epicsEnvUnset(FESTO_TEMP_CURR)
epicsEnvUnset(FESTO_TEMP_CURR_STDBY)
epicsEnvUnset(FESTO_TEMP_CURR_SCALE)

#- Pole pairs []
#-  0x216c:01, rwrwrw, uint32, 32 bit, "P1.718.0.0_numberPolePairs"
ecmcEpicsEnvSetCalc(FESTO_TEMP,"${STEPS=${MOT_STEPS=200}} / 4","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x216C,0x1,${FESTO_TEMP=50},2)"

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
ecmcEpicsEnvSetCalc(FESTO_TEMP,"${L_COIL_UH=${MOT_L_COIL_UH}} * 1e6","%lf")
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x8,${FESTO_TEMP=0.0},F32)"

#- Resistance [Ohm]
#-  0x216c:09, rwrwrw, float, 32 bit, "P1.7132.0.0_windingResistance"
ecmcEpicsEnvSetCalc(FESTO_TEMP,"${R_COIL_MOHM=${MOT_R_COIL_MOHM}} * 1000","%lf")
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x8,${FESTO_TEMP=0.0},F32)"

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
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x216C,0x18,1,U32)"

#- Velo thresholshold
#- Automatic = 0
#- Open loop = 1 default
#- Closed loop = 2
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x219C,0x8,${VELO_THRSHLD=2.0},F32)"

#- Set diag level following error to info:
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2166,0x17,4,U32)"

#- Set diag level following error to info:
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2166,0x17,4,U32)"

#- Set diag level following error velo to info:
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2166,0x19,4,U32)"

#- Set diag level for max velo monitoring
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},0x2166,0x31,4,U32)"


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
