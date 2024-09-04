#==============================================================================
# EL7221_OCT_EL72XX_OCT_SERVO.cmd
#-d /**
#-d   \brief SDOS for EL7221 drive OCT
#-d   \details Parametrization of EL7221 OCT same as EL7211 if no fan
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
#-d              INV_DIR      : Invert motor direction (0 = not invert (default), 1 = invert dir)
#-d */

#- Apply common for EL7221
ecmcFileExist("${ecmccomp_DIR}EL7221_XXX.cmd",1,1)
< ${ecmccomp_DIR}EL7221_XXX.cmd

#- Apply common for OCT
ecmcFileExist("${ecmccomp_DIR}EL72XX_OCT_EL72XX_OCT_SERVO.cmd",1,1)
< ${ecmccomp_DIR}EL72XX_OCT_EL72XX_OCT_SERVO.cmd
