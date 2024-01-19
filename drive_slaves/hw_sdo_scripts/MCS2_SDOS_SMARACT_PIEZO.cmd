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

#-############### 0x2xxx
#- SDO 0x2000, "Positioner Type"
#-   0x2000:00, rwr-r-, uint32, 32 bit, "Positioner Type"
#- SDO 0x2001, "Max Closed Loop Frequency"
#-   0x2001:00, rwrwrw, uint32, 32 bit, "Max Closed Loop Frequency"
#- SDO 0x2002, "Safe Direction"
#-   0x2002:00, rwrwrw, uint32, 32 bit, "Safe Direction"
#- SDO 0x2003, "Movement Type"
#-   0x2003:00, r-r-r-, uint32, 32 bit, "Movement Type"
#- SDO 0x2004, "Stripe Size"
#-   0x2004:00, r-r-r-, uint32, 32 bit, "Stripe Size"
#- SDO 0x2005, "Base Unit"
#-   0x2005:00, r-r-r-, uint32, 32 bit, "Base Unit"
#- SDO 0x2006, "Base Resolution"
#-   0x2006:00, r-r-r-, uint32, 32 bit, "Base Resolution"
#- SDO 0x2007, "Sensor Voltage"
#-   0x2007:00, r-r-r-, uint32, 32 bit, "Sensor Voltage"
#- SDO 0x2008, "Sensor Type"
#-   0x2008:00, r-r-r-, uint32, 32 bit, "Sensor Type"
#- SDO 0x2009, "Referencing Type"
#-   0x2009:00, r-r-r-, uint32, 32 bit, "Referencing Type"
#- SDO 0x2010, "Distance Code Type"
#-   0x2010:00, r-r-r-, uint32, 32 bit, "Distance Code Type"
#- SDO 0x2064, "Position Actual Value"
#-   0x2064:00, r-r-r-, int64, 64 bit, "Position Actual Value"
#- SDO 0x207a, "Target Position"
#-   0x207a:00, rwrwrw, int64, 64 bit, "Target Position"
#- SDO 0x20a8, "Position Unit"
#-   0x20a8:00, r-r-r-, uint32, 32 bit, "Position Unit"

#-#################################################################
#- Second SDO range (0x6xxx,0x68xx,0x7000)

ecmcEpicsEnvSetCalc(SDO_ADDRESS,"96+8*(${CH_ID=1}-1)","0x%x")

#- Must be below 4 294 967 295
#- Home velo (same to both sub index?) SEEMS THIS IS ACC?????
ecmcEpicsEnvSetCalc(MCS2_VELO,"1000000*${HOME_VELO=${MOT_HOME_VELO}}","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_ADDRESS}99,0x1,${MCS2_VELO},4)"
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