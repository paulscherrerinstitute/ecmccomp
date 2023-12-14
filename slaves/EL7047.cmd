
#-d /**
#-d   \brief SDOS for EL7037 drive
#-d   \details Parametrization of EL7037
#-d   \author Anders Sanddtröm
#-d   \file
#-d   \note Max current= 1.5 A
#-d   \note Max voltage= 24 V
#-d */

#- Currents
epicsEnvSet(DRV_I_MAX_MA,5000)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL70X7_SDOS.cmd")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")

#- Drive type
epicsEnvSet(SLAVE_TYPE,2PH_STEPPER_DRV)
