#==============================================================================
# EL7041_2PH_STEPPER.cmd
#-d /**
#-d   \brief SDOS for EL7041 drive
#-d   \details Parametrization of EL7041
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 5 A
#-d   \note Max voltage= 48 V
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"2PH_STEPPER")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"I_MAX_MA,I_STDBY_MA,U_NOM_MV,R_COIL_MOHM,STEPS,EMF,INV_DIR")

#- Currents
epicsEnvSet(DRV_I_MAX_MA,5000)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL70X1_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")

