#- Validate all choices and required mappings before changing any slave state.
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'${EC_COMP_TYPE}'!='N6' or '${SLAVE_TYPE}'!='POSITION_OUTPUT'","","#-")
${N6_PO_BAD}ecmcExit Error: PositionOutput currently supports N6 only
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'${CH_ID=1}'!='1'","","#-")
${N6_PO_BAD}ecmcExit Error: N6 position output requires CH_ID=1
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'${OUTPUT=1}'!='1' and '${OUTPUT=1}'!='2' and '${OUTPUT=1}'!='3'","","#-")
${N6_PO_BAD}ecmcExit Error: OUTPUT must be 1, 2 or 3
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'${ARM=0}'!='0' and '${ARM=0}'!='1'","","#-")
${N6_PO_BAD}ecmcExit Error: ARM must be 0 or 1
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'|${FULL_STEPS=100}|' in '|1|2|4|8|16|32|64|10|20|40|80|160|320|640|100|200|400|800|1600|3200|6400|1000|2000|4000|8000|16000|32000|64000|10000|20000|40000|80000|160000|320000|640000|100000|200000|400000|800000|1600000|3200000|6400000|1000000|2000000|4000000|8000000|16000000|32000000|64000000|'","#-","")
${N6_PO_BAD}ecmcExit Error: FULL_STEPS must be 10^n times 1,2,4,8,16,32,64 with n=0..6
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_RAW_POS=0}'!='1'","","#-")
${N6_PO_BAD}ecmcExit Error: PositionOutput requires N6_OPT RAW_POS=1 for this slave
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_MOTOR_APPLIED=0}'!='1'","","#-")
${N6_PO_BAD}ecmcExit Error: Apply the N6 motor component before PositionOutput
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_INV_DIR=0}'!='0'","","#-")
${N6_PO_BAD}ecmcExit Error: N6 raw-counter PositionOutput currently requires motor INV_DIR=0

epicsEnvSet(N6_PO_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_OUT${OUTPUT=1}_MODE=}'=='PWM'","","#-")
${N6_PO_BAD}ecmcExit Error: This N6 output is already assigned to PWMOutput

#- The first output defaults to 5 V, independently of the motor component.
#- Later outputs inherit the selected shared voltage. Input bias inherits the
#- motor selection. Resolve settings before any SDO or gate write.
epicsEnvSet(N6_PO_IO_24V,"${N6_IO_24V=${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_POS_OUT_IO_24V=0}}")
epicsEnvSet(N6_PO_PULLUP,"${N6_INPUT_PULLUP=${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_INPUT_PULLUP=0}}")
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'${N6_PO_IO_24V}'!='0' and '${N6_PO_IO_24V}'!='1'","","#-")
${N6_PO_BAD}ecmcExit Error: N6_IO_24V must be 0 (5 V) or 1 (24 V/+UB_Logic)
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'${N6_PO_PULLUP}'!='0' and '${N6_PO_PULLUP}'!='1'","","#-")
${N6_PO_BAD}ecmcExit Error: N6_INPUT_PULLUP must be 0 (pull-down) or 1 (pull-up)
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"('${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_POS_UNIT=}'!='' or '${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_PWM_APPLIED=0}'=='1') and ('${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_IO_24V=0}'!='${N6_PO_IO_24V}' or '${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_INPUT_PULLUP=0}'!='${N6_PO_PULLUP}')","","#-")
${N6_PO_BAD}ecmcExit Error: N6 I/O voltage and input pull-up are shared; configured outputs must agree

#- Canonical step unit and divider. Different outputs share the position unit.
epicsEnvSet(N6_PO_UNIT,0x00AC0000)
epicsEnvSet(N6_PO_DIV,${FULL_STEPS=100})
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"'|${FULL_STEPS=100}|' in '|10|20|40|80|160|320|640|'","","#-")
${N6_PO_SELECT}epicsEnvSet(N6_PO_UNIT,0x01AC0000)
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_DIV,"${FULL_STEPS=100}/10","%d")
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"'|${FULL_STEPS=100}|' in '|100|200|400|800|1600|3200|6400|'","","#-")
${N6_PO_SELECT}epicsEnvSet(N6_PO_UNIT,0x02AC0000)
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_DIV,"${FULL_STEPS=100}/100","%d")
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"'|${FULL_STEPS=100}|' in '|1000|2000|4000|8000|16000|32000|64000|'","","#-")
${N6_PO_SELECT}epicsEnvSet(N6_PO_UNIT,0x03AC0000)
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_DIV,"${FULL_STEPS=100}/1000","%d")
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"'|${FULL_STEPS=100}|' in '|10000|20000|40000|80000|160000|320000|640000|'","","#-")
${N6_PO_SELECT}epicsEnvSet(N6_PO_UNIT,0x04AC0000)
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_DIV,"${FULL_STEPS=100}/10000","%d")
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"'|${FULL_STEPS=100}|' in '|100000|200000|400000|800000|1600000|3200000|6400000|'","","#-")
${N6_PO_SELECT}epicsEnvSet(N6_PO_UNIT,0x05AC0000)
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_DIV,"${FULL_STEPS=100}/100000","%d")
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"'|${FULL_STEPS=100}|' in '|1000000|2000000|4000000|8000000|16000000|32000000|64000000|'","","#-")
${N6_PO_SELECT}epicsEnvSet(N6_PO_UNIT,0x06AC0000)
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_DIV,"${FULL_STEPS=100}/1000000","%d")
ecmcEpicsEnvSetCalcTernary(N6_PO_BAD,"'${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_POS_UNIT=}'!='' and '${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_POS_UNIT=}'!='${N6_PO_UNIT}'","","#-")
${N6_PO_BAD}ecmcExit Error: N6 outputs share 0x60A8; use intervals with the same canonical step-unit exponent

#- Physical output n uses routing subindex n+1 and output-word bit n+15.
ecmcEpicsEnvSetCalc(N6_PO_SUB,"${OUTPUT=1}+1","0x%02x")
ecmcEpicsEnvSetCalc(N6_PO_BIT,"${OUTPUT=1}+15","%d")
ecmcEpicsEnvSetCalc(N6_PO_ROUTE,"2304+${N6_PO_BIT}","0x%04x")
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"${N6_PO_DIV}==2","","#-")
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_ROUTE,"2560+${N6_PO_BIT}","0x%04x")
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"${N6_PO_DIV}==4","","#-")
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_ROUTE,"2816+${N6_PO_BIT}","0x%04x")
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"${N6_PO_DIV}==8","","#-")
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_ROUTE,"3072+${N6_PO_BIT}","0x%04x")
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"${N6_PO_DIV}==16","","#-")
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_ROUTE,"3328+${N6_PO_BIT}","0x%04x")
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"${N6_PO_DIV}==32","","#-")
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_ROUTE,"3584+${N6_PO_BIT}","0x%04x")
ecmcEpicsEnvSetCalcTernary(N6_PO_SELECT,"${N6_PO_DIV}==64","","#-")
${N6_PO_SELECT}ecmcEpicsEnvSetCalc(N6_PO_ROUTE,"3840+${N6_PO_BIT}","0x%04x")
