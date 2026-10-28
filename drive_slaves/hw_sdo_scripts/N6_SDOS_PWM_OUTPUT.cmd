#- Configure the selected PWM generator and physical output only.
ecmcConfigOrDie "Cfg.WriteEcEntryEcPath(ec${ECMC_EC_MASTER_ID=0}.s${COMP_S_ID}.binaryOutputArray01.${N6_PWM_BIT},0)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x323A,0x01,${N6_PWM_IO_24V},1)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x323A,0x02,${N6_PWM_PULLUP},1)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${N6_PWM_INDEX},0x02,0,4)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${N6_PWM_INDEX},0x01,${N6_PWM_HZ},4)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x3252,${N6_PWM_SUB},${N6_PWM_ROUTE},2)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},${N6_PWM_INDEX},0x02,${N6_PWM_DUTY},4)"
ecmcConfigOrDie "Cfg.WriteEcEntryEcPath(ec${ECMC_EC_MASTER_ID=0}.s${COMP_S_ID}.binaryOutputArray01.${N6_PWM_BIT},${ARM=0})"
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_PWM${PWM_ID=0}_HZ,${N6_PWM_HZ})
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_PWM${PWM_ID=0}_DUTY,${N6_PWM_DUTY})
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_PWM_APPLIED,1)
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_OUT${OUTPUT=1}_MODE,PWM)
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_IO_24V,${N6_PWM_IO_24V})
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_POS_OUT_IO_24V,${N6_PWM_IO_24V})
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_INPUT_PULLUP,${N6_PWM_PULLUP})
