#-d /**
#-d   \brief SDOS for MCS2 drive
#-d   \details Parametrization of MCS2
#-d   \author Anders Sandström
#-d   \file
#-d */

#- CH1:  0x2000
#- CH2:  0x2800
#- CH3:  0x3000

ecmcEpicsEnvSetCalc(SDO_ADDRESS,"8192+2048*(${CH_ID=1}-1)","0x%x")

#- Set Positioner type
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${SDO_ADDRESS},0x0,${POS_TYPE=${MOT_POS_TYPE}},4)"
epicsEnvUnset(SDO_ADDRESS)

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
