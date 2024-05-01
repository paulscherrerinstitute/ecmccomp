#==============================================================================
# EL7211_RES_EL72XX_RES_SERVO.cmd
#-d /**
#-d   \brief SDOS for EL7211 drive RES
#-d   \details Parametrization of EL7211 Resolver version
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 9 A
#-d   \note Max voltage= 48 V
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d              I_MAX_MA     : Max current [mA]  (Used to reduce max torque)
#-d              U_NOM_MV     : Supply voltage [mV] (defaults to Motor or Slave setting)
#-d              CURR_KP      : Current controller KP (defaults to motor setting)
#-d              CURR_TI      : Current controller TI (defaults to motor setting)
#-d              VELO_KP      : Velocity controller KP (defaults to motor setting)
#-d              VELO_TI      : Velocity controller TI (defaults to motor setting)
#-d              BRK_APP_DLY  : Brake application delay (defaults to motor setting or 0)
#-d              BRK_REL_DLY  : Brake release delay (defaults to motor setting or 0)
#-d */

#- Apply common for EL7211
ecmcFileExist("${ecmccomp_DIR}EL7211_XXX.cmd",1,1)
< ${ecmccomp_DIR}EL7211_XXX.cmd

#- Apply common for RES
ecmcFileExist("${ecmccomp_DIR}EL72XX_RES_EL72XX_RES_SERVO.cmd",1,1)
< ${ecmccomp_DIR}EL72XX_RES_EL72XX_RES_SERVO.cmd
