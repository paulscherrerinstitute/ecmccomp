#-d /**
#-d   \brief SDOS for ELM7221 drive OCT
#-d   \details Parametrization of EL7221 OCT
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 9 A
#-d   \note Nominal current= 4.5 A
#-d   \note Max voltage= 48 V
#-d */

#- Currents
epicsEnvSet(DRV_I_MAX_MA,9000)

#- Currents (nominal)
epicsEnvSet(DRV_I_NOM_MA,4500)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)
