#-d /**
#-d   \brief SDOS for EL7211 drive
#-d   \details Parametrization of EL7211
#-d   \author Anders Sanddtröm
#-d   \file
#-d   \note Max current= 9 A
#-d   \note Max voltage= 48 V
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,EL7211_SERVO)

#- Currents
epicsEnvSet(DRV_I_MAX_MA,9000)

#- Currents (nominal)
epicsEnvSet(DRV_I_RUN_MA,4500)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL72XX_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")
