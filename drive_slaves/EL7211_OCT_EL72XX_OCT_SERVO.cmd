#==============================================================================
# EL7211_RES_EL72XX_OCT_SERVO.cmd
#-d /**
#-d   \brief SDOS for EL7211 drive OCT
#-d   \details Parametrization of EL7211
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 9 A
#-d   \note Max voltage= 48 V
#-d */

#- Apply common for EL7211
ecmcFileExist("${ecmccomp_DIR}EL7211_XXX.cmd",1,1)
< ${ecmccomp_DIR}EL7211_XXX.cmd.cmd

#- Apply common for OCT
ecmcFileExist("${ecmccomp_DIR}EL72XX_OCT.cmd",1,1)
< ${ecmccomp_DIR}EL72XX_XXX.cmd
