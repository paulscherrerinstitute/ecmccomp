#==============================================================================
# cleanupEL72XX_OCT_SERVO.cmd

#- Almost same as resolver version 
< ${ecmccomp_DIR}cleanupEL72XX_RES_SERVO.cmd

epicsEnvUnset(INV_DIR)
epicsEnvUnset(ENC_OFF)
