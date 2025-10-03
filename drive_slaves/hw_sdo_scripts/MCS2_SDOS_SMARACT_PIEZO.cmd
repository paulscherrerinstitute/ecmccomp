#==============================================================================
# MCS2_SDOS_SMARACT_PIEZO.cmd
#-d /**
#-d   \brief SDOS for MCS2 drive
#-d   \details Parametrization of MCS2
#-d   \author Anders Sandström
#-d   \file
#-d */

#- CH1:  0x2000, 0x6000
#- CH2:  0x2800, 0x6800
#- CH3:  0x3000, 0x7000

#-#################################################################
#- First SDO range (0x2xxx,0x28xx,0x3000)
ecmcEpicsEnvSetCalc(SDO_ADDRESS,"32+8*(${CH_ID=1}-1)","0x%x")

#- Set Positioner type
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_ADDRESS}00,0x0,${POS_TYPE=${MOT_POS_TYPE}},4)"
epicsEnvUnset(POS_TYPE)

ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_ADDRESS}0c,0x0,${POS_TYPE=${SAFE_DIR=0}},1)"
epicsEnvUnset(SAFE_DIR)

#- Referencing Options 
#- bit 0: Start direction (0 = forward)
#- bit 1: Reverse direction, only valid for positioners with multi ref-marks, will reverse search dir as sson the first mark is found (0 = not reverse)
#- bit 2: Auto zero, teh current position is set to zero when finding teh ref pos (this seems to work like this without setting this bit)
#- bit 3: Abort on endstop
#- bit 4: Continue motion on reffound (will not stop, must stop manually).. Strange option
#- bit 5: Stop motion immediately when finding the ref
#- bit 24: Invalidate home flag
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_ADDRESS}0b,0x0,${POS_TYPE=${REF_OPTS=0}},1)"
epicsEnvUnset(REF_OPTS)

#-############### 0x2xxx
#-SDO 0x2000, "Positioner Type"
#-  0x2000:00, rwr-r-, uint32, 32 bit, "Positioner Type"
#-SDO 0x2001, "Max Closed Loop Frequency"
#-  0x2001:00, rwrwrw, uint32, 32 bit, "Max Closed Loop Frequency"
#-SDO 0x2003, "Movement Type"
#-  0x2003:00, r-r-r-, uint32, 32 bit, "Movement Type"
#-SDO 0x2004, "Calibration Options"
#-  0x2004:00, rwrwrw, type 002f, 32 bit, "Calibration Options"
#-SDO 0x2005, "Base Unit"
#-  0x2005:00, r-r-r-, uint32, 32 bit, "Base Unit"
#-SDO 0x2006, "Base Resolution"
#-  0x2006:00, r-r-r-, int32, 32 bit, "Base Resolution"
#-SDO 0x2007, "Sensor Power Mode"
#-  0x2007:00, rwrwrw, uint32, 32 bit, "Sensor Power Mode"
#-SDO 0x2008, "Logical Scale Offset"
#-  0x2008:00, rwrwrw, int64, 64 bit, "Logical Scale Offset"
#-SDO 0x2009, "Logical Scale Inversion"
#-  0x2009:00, rwr-r-, bool, 1 bit, "Logical Scale Inversion"
#-SDO 0x200a, "Reference Type"
#-  0x200a:00, r-r-r-, uint32, 32 bit, "Reference Type"
#-SDO 0x200b, "Referencing Options"
#-  0x200b:00, rwrwrw, type 002f, 32 bit, "Referencing Options"
#-SDO 0x200c, "Safe Direction"
#-  0x200c:00, rwr-r-, bool, 1 bit, "Safe Direction"
#-SDO 0x200d, "Motor Load"
#-  0x200d:00, r-r-r-, uint8, 8 bit, "Motor Load"
#-SDO 0x200e, "Software Range Limits"
#-  0x200e:00, r-r-r-, uint8, 8 bit, "SubIndex 000"
#-  0x200e:01, rwrwrw, int64, 64 bit, "SubIndex 001"
#-  0x200e:02, rwrwrw, int64, 64 bit, "SubIndex 002"
#-SDO 0x200f, "Channel Type"
#-  0x200f:00, r-r-r-, uint32, 32 bit, "Channel Type"
#-SDO 0x2020, "Open Loop Scan Target"
#-  0x2020:00, rwrwrw, int32, 32 bit, "Open Loop Scan Target"
#-SDO 0x2021, "Open Loop Scan Velocity"
#-  0x2021:00, rwrwrw, uint64, 64 bit, "Open Loop Scan Velocity"
#-SDO 0x2022, "Open Loop Step Count"
#-  0x2022:00, rwrwrw, int32, 32 bit, "Open Loop Step Count"
#-SDO 0x2023, "Open Loop Step Amplitude"
#-  0x2023:00, rwrwrw, uint16, 16 bit, "Open Loop Step Amplitude"
#-SDO 0x2024, "Open Loop Step Frequency"
#-  0x2024:00, rwrwrw, uint16, 16 bit, "Open Loop Step Frequency"


#-#################################################################
#- Second SDO range (0x6xxx,0x68xx,0x7000)

ecmcEpicsEnvSetCalc(SDO_ADDRESS,"96+8*(${CH_ID=1}-1)","0x%x")

#- Must be below 4 294 967 295
#- Home velo (same to both sub index?)
ecmcEpicsEnvSetCalc(MCS2_VELO,"1000*${HOME_VELO=${MOT_HOME_VELO}}","%d")
#- Slow
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_ADDRESS}99,0x1,${MCS2_VELO},4)"
#- Fast
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_ADDRESS}99,0x2,${MCS2_VELO},4)"

#- Must be below 4 294 967 295
#- Home acc
ecmcEpicsEnvSetCalc(MCS2_ACC,"1000000*${HOME_ACC=${MOT_HOME_ACC}}","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_ADDRESS}9A,0x0,${MCS2_ACC},4)"

#- Home method
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_ADDRESS}98,0x0,${HOME_METHOD_ID=${MOT_HOME_METHOD_ID}},1)"

epicsEnvUnset(MCS2_VELO)
epicsEnvUnset(MCS2_ACC)
epicsEnvUnset(SDO_ADDRESS)

#-############### 0x6xxx
#- SDO 0x603f, "Error Code"
#-   0x603f:00, r-r-r-, uint16, 16 bit, "Error Code"
#- SDO 0x6040, "Control Word"
#-   0x6040:00, rwrwrw, uint16, 16 bit, "Control Word"
#- SDO 0x6041, "Status Word"
#-   0x6041:00, r-r-r-, uint16, 16 bit, "Status Word"
#- SDO 0x605a, "Quick Stop Option Code"
#-   0x605a:00, rwrwrw, int16, 16 bit, "Quick Stop Option Code"
#- SDO 0x605b, "Shutdown Option Code"
#-   0x605b:00, rwrwrw, int16, 16 bit, "Shutdown Option Code"
#- SDO 0x605c, "Disable Operation Option Code"
#-   0x605c:00, rwrwrw, int16, 16 bit, "Disable Operation Option Code"
#- SDO 0x605e, "Fault Reaction Option Code"
#-   0x605e:00, rwrwrw, int16, 16 bit, "Fault Reaction Option Code"
#- SDO 0x6060, "Modes of Operation"
#-   0x6060:00, rwrwrw, int8, 8 bit, "Modes of Operation"
#- SDO 0x6061, "Modes of Operation Display"
#-   0x6061:00, r-r-r-, int8, 8 bit, "Modes of Operation Display"
#- SDO 0x6064, "Position Actual Value"
#-   0x6064:00, r-r-r-, int32, 32 bit, "Position Actual Value"
#- SDO 0x606c, "Velocity Actual Value"
#-   0x606c:00, r-r-r-, int32, 32 bit, "Velocity Actual Value"
#- SDO 0x6077, "Torque Actual Value"
#-   0x6077:00, r-r-r-, int16, 16 bit, "Torque Actual Value"
#- SDO 0x607a, "Target Position"
#-   0x607a:00, rwrwrw, int32, 32 bit, "Target Position"
#- SDO 0x607b, "Position Range Limits"
#-   0x607b:00, r-r-r-, uint8, 8 bit, "SubIndex 000"
#-   0x607b:01, rwrwrw, int32, 32 bit, "SubIndex 001"
#-   0x607b:02, rwrwrw, int32, 32 bit, "SubIndex 002"
#- SDO 0x607d, "Software Position Limits"
#-   0x607d:00, r-r-r-, uint8, 8 bit, "SubIndex 000"
#-   0x607d:01, rwrwrw, int32, 32 bit, "SubIndex 001"
#-   0x607d:02, rwrwrw, int32, 32 bit, "SubIndex 002"
#- SDO 0x6081, "Profile Velocity"
#-   0x6081:00, rwrwrw, uint32, 32 bit, "Profile Velocity"
#- SDO 0x6083, "Profile Acceleration"
#-   0x6083:00, rwrwrw, uint32, 32 bit, "Profile Acceleration"
#- SDO 0x6085, "Quick Stop Deceleration"
#-   0x6085:00, rwrwrw, uint32, 32 bit, "Quick Stop Deceleration"
#- SDO 0x608f, "Position Encoder Resolution"
#-   0x608f:00, r-r-r-, uint8, 8 bit, "SubIndex 000"
#-   0x608f:01, rwrwrw, uint32, 32 bit, "SubIndex 001"
#-   0x608f:02, rwrwrw, uint32, 32 bit, "SubIndex 002"
#- SDO 0x6098, "Homing Method"
#-   0x6098:00, rwrwrw, int8, 8 bit, "Homing Method"
#- SDO 0x6099, "Homing Speed"
#-   0x6099:00, r-r-r-, uint8, 8 bit, "SubIndex 000"
#-   0x6099:01, rwrwrw, uint32, 32 bit, "SubIndex 001"
#-   0x6099:02, rwrwrw, uint32, 32 bit, "SubIndex 002"
#- SDO 0x609a, "Homing Acceleration"
#-   0x609a:00, rwrwrw, uint32, 32 bit, "Homing Acceleration"
#- SDO 0x60c2, "Interpolation Time Period"
#-   0x60c2:00, r-r-r-, uint8, 8 bit, "SubIndex 000"
#-   0x60c2:01, rwrwrw, uint8, 8 bit, "Interpolation time period value"
#-   0x60c2:02, rwrwrw, int8, 8 bit, "Interpolation time index"
#- SDO 0x60e3, "Supported Homing Methods"
#-   0x60e3:00, r-r-r-, uint8, 8 bit, "SubIndex 000"
#-   0x60e3:01, r-r-r-, int8, 8 bit, "SubIndex 001"
#-   0x60e3:02, r-r-r-, int8, 8 bit, "SubIndex 002"
#-   0x60e3:03, r-r-r-, int8, 8 bit, "SubIndex 003"
#-   0x60e3:04, r-r-r-, int8, 8 bit, "SubIndex 004"
#-   0x60e3:05, r-r-r-, int8, 8 bit, "SubIndex 005"
#-   0x60e3:06, r-r-r-, int8, 8 bit, "SubIndex 006"
#-   0x60e3:07, r-r-r-, int8, 8 bit, "SubIndex 007"
#-   0x60e3:08, r-r-r-, int8, 8 bit, "SubIndex 008"
#-   0x60e3:09, r-r-r-, int8, 8 bit, "SubIndex 009"
#-   0x60e3:0a, r-r-r-, int8, 8 bit, "SubIndex 010"
#-   0x60e3:0b, r-r-r-, int8, 8 bit, "SubIndex 011"
#-   0x60e3:0c, r-r-r-, int8, 8 bit, "SubIndex 012"
#- SDO 0x60f4, "Following Error Actual Value"
#-   0x60f4:00, r-r-r-, int32, 32 bit, "Following Error Actual Value"
#- SDO 0x60ff, "Target Velocity"
#-   0x60ff:00, rwrwrw, int32, 32 bit, "Target Velocity"
#- SDO 0x6502, "Supported Drive Modes"
#-   0x6502:00, r-r-r-, uint32, 32 bit, "Supported Drive Modes"
#- SDO 0x67ff, "Device type"
#-   0x67ff:00, r-r-r-, uint32, 32 bit, "Device type"
#- 

#- Settings done
ecmcConfig "Cfg.EcSetSlaveSDOSettingsDone(${COMP_S_ID},${CH_ID=1},1)"
