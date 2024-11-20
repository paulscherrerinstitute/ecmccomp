#- Recalc technosoft data format
#- MACROS:
#-   IN_VAL: data for value to convert
#-   OUT_FORMAT : Output format (default %04x)
#-  The result will be stored in (please cleanup after use)
#-    IPOS_OUT_VAL
#-    IPOS_OUT_EXP
#- Example Kp:
#-  Kp=KPI/32767*2^SFTKPI
#- How many divisions with 2 is needed to get below 1
#- x=log(ECMC_KPI_TEMP)/log(2)

ecmcEpicsEnvSetCalc(IPOS_OUT_EXP,"log(${IN_VAL})/log(2);","%lf")
epicsEnvShow(IPOS_OUT_EXP)
ecmcEpicsEnvSetCalcTernary(IPOS_OUT_EXP,"${IPOS_OUT_EXP} < 0","0", "ceil(${IPOS_OUT_EXP});")
# eval ceil if needed
ecmcEpicsEnvSetCalc(IPOS_OUT_EXP,"${IPOS_OUT_EXP}")
epicsEnvShow(IPOS_OUT_VAL)
ecmcEpicsEnvSetCalc(IPOS_OUT_VAL,"${IN_VAL}*32767/pow(2,${IPOS_OUT_EXP});","%d")
epicsEnvShow(IPOS_OUT_VAL)
# Convert format
ecmcEpicsEnvSetCalc(IPOS_OUT_VAL,"${IPOS_OUT_VAL};",${OUT_FORMAT='%04x'})
ecmcEpicsEnvSetCalc(IPOS_OUT_EXP,"${IPOS_OUT_EXP};",${OUT_FORMAT='%04x'})
epicsEnvShow(IPOS_OUT_VAL)
epicsEnvShow(IPOS_OUT_EXP)
