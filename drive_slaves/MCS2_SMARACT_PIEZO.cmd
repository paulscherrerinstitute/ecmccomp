#==============================================================================
# MCS2_SMARACT_PIEZO.cmd
#-d /**
#-d   \brief SDOS for SmaraAct MCS2
#-d   \details Parametrization of EL7047
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 5 A
#-d   \note Max voltage= 48 V
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d              POS_TYPE     : Positioner type
#-d              HOME_VELO    : Homing velocity
#-d              HOME_ACC     : Homing Acceleration
#-d              HOME_METHOD_ID : Homing method id
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"MCS2_DRIVE")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"POS_TYPE,HOME_VELO,HOME_ACC,HOME_METHOD_ID")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"MCS2_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"3")
