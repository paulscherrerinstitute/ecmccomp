#-d /**
#-d   \brief SDOS for ELM7231 drive OCT
#-d   \details Parametrization of EL7231 OCT
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 32 A
#-d   \note Nominal current= 16 A
#-d   \note Max voltage= 48 V
#-d */

#- Currents
epicsEnvSet(DRV_I_MAX_MA,32000)

#- Currents (nominal)
epicsEnvSet(DRV_I_NOM_MA,16000)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)
