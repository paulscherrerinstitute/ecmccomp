#-d /**
#-d   \brief SDOS for EL7047 drive
#-d   \details Parametrization of EL7047
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 5 A
#-d   \note Max voltage= 48 V
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"2PH_STEPPER")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"I_MAX_MA,I_STDBY_MA,U_NOM_MV,R_COIL_MOHM,L_COIL_UH,STEPS,INV_DIR")

#- Currents
epicsEnvSet(DRV_I_MAX_MA,5000)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL70X7_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")
