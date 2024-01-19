#==============================================================================
# EL7221_RES_EL72XX_RES_SERVO.cmd
#-d /**
#-d   \brief SDOS for EL7221 drive RES
#-d   \details Parametrization of EL7221 Resolver version, same as EL7211 if no fan
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 9 A
#-d   \note Max voltage= 48 V
#-d */

#- Apply common for EL7221
ecmcFileExist("${ecmccomp_DIR}EL7221_XXX.cmd",1,1)
< ${ecmccomp_DIR}EL7221_XXX.cmd.cmd

#- Apply common for RES
ecmcFileExist("${ecmccomp_DIR}EL72XX_RES.cmd",1,1)
< ${ecmccomp_DIR}EL72XX_XXX.cmd
