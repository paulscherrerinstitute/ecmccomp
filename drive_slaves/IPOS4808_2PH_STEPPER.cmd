#==============================================================================
# iPOS4808BX_2PH_STEPPER.cmd
#-d /**
#-d   \brief SDOS for IPOS4808BX
#-d   \details Parametrization of Technosoft IPOS4808
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 8 A
#-d   \note Max voltage= 48 V
#-d
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d          2PH_STEPPER    (general 2PH stepper cfgs):
#-d              I_MAX_MA                : Run current [mA] (Used to reduce max torque)
#-d              I_STDBY_MA              : Standby current [mA]
#-d          Specific to this slave:
#-d              CURR_KP    : MANDATORY!! Current controller amplification gain
#-d              CURR_TI    : MANDATORY!! Current controller integration gain
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"2PH_STEPPER")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"I_MAX_MA,I_STDBY_MA,CURR_KP,CURR_TI")

#- Currents
epicsEnvSet(DRV_I_MAX_MA,8000)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"IPOS4808_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")
