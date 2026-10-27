#- N6 position output using scaled 0x6064 and raw 0x6063 axis feedback.
#- Requires ecmccfg N6-1-1-1-S_OPT with RAW_POS=1 and a motor applied first.
epicsEnvSet(SLAVE_TYPE,POSITION_OUTPUT)
epicsEnvSet(SUPP_MACROS,"FULL_STEPS,OUTPUT,ARM,N6_IO_24V,N6_INPUT_PULLUP")
epicsEnvSet(SLAVE_SCRIPT,N6_SDOS)
epicsEnvSet(SLAVE_CHANNELS,1)
