#-d /**
#-d   \brief SDOS for Festo CMMT-ST drive
#-d   \details Parametrization of Festo CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 8 A
#-d   \note Max voltage= 48 V
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"2PH_STEPPER,BISS_C_ENC")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"I_MAX_MA,I_STDBY_MA,U_NOM_MV,R_COIL_MOHM,STEPS,EMF,INV_DIR")

#- Currents
epicsEnvSet(DRV_I_MAX_MA,8000)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"Festo-CMMT-ST_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")
