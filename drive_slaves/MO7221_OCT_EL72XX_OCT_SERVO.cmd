#==============================================================================
# MO7221_OCT_EL72XX_OCT_SERVO.cmd
#-d /**
#-d   \brief SDO configuration for the MO7221 OCT drive
#-d   \details The MO7221 uses the EL72XX OCT motor model, but has a
#-d            different amplifier object dictionary.
#-d   \author Anders Sandström
#-d   \file
#-d   \note Maximum current: 8 A
#-d   \note Fixed supply voltage: 24 V; U_NOM_MV is not supported.
#-d */

#- MO7221-9016-1114 electrical limits
epicsEnvSet(DRV_I_MAX_MA,8000)
epicsEnvSet(DRV_I_NOM_MA,4000)
epicsEnvSet(DRV_U_MAX_MV,24000)

#- Reuse the EL72XX OCT component validation and motor model.
ecmcFileExist("${ecmccomp_DIR}EL72XX_OCT_EL72XX_OCT_SERVO.cmd",1,1)
< ${ecmccomp_DIR}EL72XX_OCT_EL72XX_OCT_SERVO.cmd

#- The MO has no EL-style nominal-voltage object 0x8010:19.
epicsEnvSet(SLAVE_SCRIPT,"MO7221_OCT_SDOS")
epicsEnvSet(SUPP_MACROS,"I_MAX_MA,CURR_KP,CURR_TI,VELO_KP,VELO_TI,BRK_APP_DLY,BRK_REL_DLY,INV_DIR,")
