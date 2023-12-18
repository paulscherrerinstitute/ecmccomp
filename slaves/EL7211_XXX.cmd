#-d /**
#-d   \brief SDOS for EL7211 drive XXX
#-d   \details Parametrization of EL7211
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 9 A
#-d   \note Max voltage= 48 V
#-d */

#- Currents
epicsEnvSet(DRV_I_MAX_MA,9000)

#- Currents (nominal)
epicsEnvSet(DRV_I_NOM_MA,4500)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)
