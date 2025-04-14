#==============================================================================
# EL72XX_OCT_CTRL_PARAMS.cmd
#-d /**
#-d   \brief SDOS for EL72XXdrive
#-d   \details Parametrization of EL72xx
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d          CTRL_PARAMS    (general 2PH stepper cfgs):
#-d              I_KP         : Current loop gain
#-d              I_TI         : Current loop integration time
#-d              V_KP         : Velocity loop gain
#-d              V_TI         : Velocity loop integration time
#-d              P_KP         : Position loop gain
#-d */

ecmcFileExist("${ecmccomp_DIR}EL72XX_XXX_CTRL_PARAMS.cmd",1,1)
< ${ecmccomp_DIR}EL72XX_XXX_CTRL_PARAMS.cmd

