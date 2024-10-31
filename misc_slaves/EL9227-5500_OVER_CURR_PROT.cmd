#==============================================================================
# EL9227-5500_OVER_CURR_PROT.cmd
#-d /**
#-d   \brief SDOS for EL9227-5500 over current protection
#-d   \details Parametrization of EL9227-5500, 2CH, 24V, max 10A (sum of both channels)
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 10 A (sum of both channels)
#-d   \note Max voltage= 24 V
#-d   \param MACROS
#-d          OVER_CURR_PROT
#-d              I_MAX_MA     : Fuse current [mA], NOTE: the setting will be converted to integer Amps
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"OVER_CURR_PROT")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"I_MAX_MA")

#- Currents (sum of both channels)
epicsEnvSet(PROT_I_MAX_MA,10000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL9227-5500_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"2")
