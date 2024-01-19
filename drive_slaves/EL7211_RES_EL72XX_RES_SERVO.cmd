#==============================================================================
# EL7211_RES_EL72XX_RES_SERVO.cmd
#-d /**
#-d   \brief SDOS for EL7211 drive RES
#-d   \details Parametrization of EL7211 Resolver version
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 9 A
#-d   \note Max voltage= 48 V
#-d */

#- Apply common for EL7211
ecmcFileExist("${ecmccomp_DIR}EL7211_XXX.cmd",1,1)
< ${ecmccomp_DIR}EL7211_XXX.cmd.cmd

#- Apply common for RES
ecmcFileExist("${ecmccomp_DIR}EL72XX_RES.cmd",1,1)
< ${ecmccomp_DIR}EL72XX_XXX.cmd
