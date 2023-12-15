#-d /**
#-d   \brief SDOS for EL7041 drive
#-d   \details Parametrization of EL7041
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 1.5 A
#-d   \note Max voltage= 24 V
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"2PH_STEPPER,INC_ENC")

#- Currents
epicsEnvSet(DRV_I_MAX_MA,5000)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL70X1_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")

