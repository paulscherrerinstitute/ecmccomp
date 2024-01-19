#==============================================================================
# Festo-CMMT-ST_2PH_STEPPER.cmd
#-d /**
#-d   \brief SDOS for Festo CMMT-ST drive
#-d   \details Parametrization of Festo CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 8 A
#-d   \note Max voltage= 48 V
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"2PH_STEPPER")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"I_MAX_MA,I_STDBY_MA,U_NOM_MV,R_COIL_MOHM,STEPS,INV_DIR,ROT_INERTIA_GCM2,L_COIL_UH,R_COIL_MOHM")

#- Currents
epicsEnvSet(DRV_I_MAX_MA,8000)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"Festo-CMMT-ST_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")
