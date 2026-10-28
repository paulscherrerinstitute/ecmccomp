#- Validate every option/capability before any output write or SDO is queued.
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${EC_COMP_TYPE}'!='N6' or '${SLAVE_TYPE}'!='PWM_OUTPUT'","","#-")
${N6_PWM_BAD}ecmcExit Error: PWMOutput currently supports N6 only
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${CH_ID=1}'!='1'","","#-")
${N6_PWM_BAD}ecmcExit Error: N6 PWM output requires CH_ID=1
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${OUTPUT=1}'!='1' and '${OUTPUT=1}'!='2' and '${OUTPUT=1}'!='3'","","#-")
${N6_PWM_BAD}ecmcExit Error: OUTPUT must be 1, 2 or 3
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${PWM_ID=0}'!='0' and '${PWM_ID=0}'!='1'","","#-")
${N6_PWM_BAD}ecmcExit Error: PWM_ID must be 0 or 1
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${ARM=0}'!='0' and '${ARM=0}'!='1'","","#-")
${N6_PWM_BAD}ecmcExit Error: ARM must be 0 or 1
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"${FREQUENCY_HZ=2000}<50 or ${FREQUENCY_HZ=2000}>2000 or floor(${FREQUENCY_HZ=2000})!=${FREQUENCY_HZ=2000}","","#-")
${N6_PWM_BAD}ecmcExit Error: FREQUENCY_HZ must be an integer 50..2000
ecmcEpicsEnvSetCalc(N6_PWM_HZ,"${FREQUENCY_HZ=2000}","%d")
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${FREQUENCY_HZ=2000}'!='${N6_PWM_HZ}'","","#-")
${N6_PWM_BAD}ecmcExit Error: FREQUENCY_HZ must use plain integer notation
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"${DUTY_PERCENT=50}<0 or ${DUTY_PERCENT=50}>100 or floor(${DUTY_PERCENT=50})!=${DUTY_PERCENT=50}","","#-")
${N6_PWM_BAD}ecmcExit Error: DUTY_PERCENT must be an integer 0..100
ecmcEpicsEnvSetCalc(N6_PWM_DUTY,"${DUTY_PERCENT=50}","%d")
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${DUTY_PERCENT=50}'!='${N6_PWM_DUTY}'","","#-")
${N6_PWM_BAD}ecmcExit Error: DUTY_PERCENT must use plain integer notation
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_RAW_POS=-1}'!='0' and '${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_RAW_POS=-1}'!='1'","","#-")
${N6_PWM_BAD}ecmcExit Error: PWMOutput requires N6_OPT for this master/slave
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_MOTOR_APPLIED=0}'!='1'","","#-")
${N6_PWM_BAD}ecmcExit Error: Apply the N6 motor component before PWMOutput
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_OUT${OUTPUT=1}_MODE=}'!='' and '${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_OUT${OUTPUT=1}_MODE=}'!='PWM'","","#-")
${N6_PWM_BAD}ecmcExit Error: This N6 output is already assigned to PositionOutput
#- PWM generators are shared across physical outputs.
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_PWM${PWM_ID=0}_HZ=}'!='' and ('${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_PWM${PWM_ID=0}_HZ=}'!='${N6_PWM_HZ}' or '${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_PWM${PWM_ID=0}_DUTY=}'!='${N6_PWM_DUTY}')","","#-")
${N6_PWM_BAD}ecmcExit Error: N6 outputs sharing a PWM_ID must use identical frequency and duty
#- Share the first output voltage with PositionOutput; motor bias is inherited.
epicsEnvSet(N6_PWM_IO_24V,"${N6_IO_24V=${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_POS_OUT_IO_24V=0}}")
epicsEnvSet(N6_PWM_PULLUP,"${N6_INPUT_PULLUP=${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_INPUT_PULLUP=0}}")
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${N6_PWM_IO_24V}'!='0' and '${N6_PWM_IO_24V}'!='1'","","#-")
${N6_PWM_BAD}ecmcExit Error: N6_IO_24V must be 0 or 1
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"'${N6_PWM_PULLUP}'!='0' and '${N6_PWM_PULLUP}'!='1'","","#-")
${N6_PWM_BAD}ecmcExit Error: N6_INPUT_PULLUP must be 0 or 1
epicsEnvSet(N6_PWM_BAD,"")
ecmcEpicsEnvSetCalcTernary(N6_PWM_BAD,"('${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_POS_UNIT=}'!='' or '${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_PWM_APPLIED=0}'=='1') and ('${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_IO_24V=0}'!='${N6_PWM_IO_24V}' or '${ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_INPUT_PULLUP=0}'!='${N6_PWM_PULLUP}')","","#-")
${N6_PWM_BAD}ecmcExit Error: N6 I/O voltage and input pull-up are shared; configured outputs must agree
ecmcEpicsEnvSetCalc(N6_PWM_BIT,"${OUTPUT=1}+15","%d")
ecmcEpicsEnvSetCalc(N6_PWM_SUB,"${OUTPUT=1}+1","0x%02x")
ecmcEpicsEnvSetCalc(N6_PWM_INDEX,"12896+${PWM_ID=0}","0x%04x")
ecmcEpicsEnvSetCalc(N6_PWM_ROUTE,"4608+256*${PWM_ID=0}+${N6_PWM_BIT}","0x%04x")
