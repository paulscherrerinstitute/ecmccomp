#- The validator has established the mapping and motor configuration.
#- Modify only the selected bit in the existing output-word buffer. This avoids
#- clearing brake control or gates owned by other outputs.
ecmcConfigOrDie "Cfg.WriteEcEntryEcPath(ec${ECMC_EC_MASTER_ID=0}.s${COMP_S_ID}.binaryOutputArray01.${N6_PO_BIT},0)"
#- 0x323A:01 selects BOTH input thresholds and output voltage for the drive.
#- 0 selects 5 V; 1 selects 24 V inputs and +UB_Logic outputs.
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x323A,0x01,${N6_PO_IO_24V},1)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x323A,0x02,${N6_PO_PULLUP},1)"
#- Keep the sensorless observer disabled: the tested signal is the OL counter.
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x60E6,0x01,0,4)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x60A8,0x00,${N6_PO_UNIT},4)"
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x3252,${N6_PO_SUB},${N6_PO_ROUTE},2)"
ecmcConfigOrDie "Cfg.WriteEcEntryEcPath(ec${ECMC_EC_MASTER_ID=0}.s${COMP_S_ID}.binaryOutputArray01.${N6_PO_BIT},${ARM=0})"
#- Remember the shared unit so a later output cannot silently change its period.
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_POS_UNIT,${N6_PO_UNIT})
#- Later output components inherit these settings instead of reverting them.
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_IO_24V,${N6_PO_IO_24V})
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_INPUT_PULLUP,${N6_PO_PULLUP})
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_POS_OUT_IO_24V,${N6_PO_IO_24V})
epicsEnvSet(ECMC_N6_M${ECMC_EC_MASTER_ID=0}_S${COMP_S_ID}_OUT${OUTPUT=1}_MODE,POSITION)
