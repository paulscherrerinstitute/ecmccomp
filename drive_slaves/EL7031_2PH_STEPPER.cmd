#==============================================================================
# EL7031_2PH_STEPPER.cmd
#-d /**
#-d   \brief SDOS for EL7031 drive
#-d   \details Parametrization of EL7031
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 1.5 A
#-d   \note Max voltage= 24 V
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d          2PH_STEPPER    (general 2PH stepper cfgs):
#-d              I_MAX_MA     : Run current [mA] (Used to reduce max torque)
#-d              I_STDBY_MA   : Standby current [mA]
#-d              U_NOM_MV     : Supply voltage [mV]
#-d              INV_DIR      : Invert motor direction (0 = not invert (default), 1 = invert dir)
#-d              R_COIL_MOHM  : Coil resistance in mOhm
#-d   \param Not supported MACROS from 2PH_STEPPPER:
#-d              L_COIL_UH    : Coil inductance in uH NOT SUPPORTED 
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"2PH_STEPPER")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"I_MAX_MA,I_STDBY_MA,U_NOM_MV,R_COIL_MOHM,STEPS,EMF,INV_DIR")

#- Currents
epicsEnvSet(DRV_I_MAX_MA,1500)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,24000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL70X1_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")
