#==============================================================================
# EL72XX_OCT_CTRL_PARAMS.cmd
#-d /**
#-d   \brief SDOS for EL7062 drive
#-d   \details Parametrization of EL7062
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

#- Drive type
epicsEnvSet(SLAVE_TYPE,"CTRL_PARAMS")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"I_KP,I_TI,V_KP,V_TI,P_KP")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL72XX_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")
