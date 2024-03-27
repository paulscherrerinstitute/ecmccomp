#==============================================================================
# Festo-CMMT-ST_2PH_STEPPER.cmd
#-d /**
#-d   \brief SDOS for Festo CMMT-ST drive
#-d   \details Parametrization of Festo CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 8 A
#-d   \note Max voltage= 48 V
#-d
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d          2PH_STEPPER    (general 2PH stepper cfgs):
#-d              I_MAX_MA     : Run current [mA] (Used to reduce max torque)
#-d              I_STDBY_MA   : Standby current [mA]
#-d              U_NOM_MV     : Supply voltage [mV]
#-d              INV_DIR      : Invert motor direction (0 = not invert (default), 1 = invert dir)
#-d              R_COIL_MOHM  : Coil resistance [mOhm]
#-d              L_COIL_UH    : Coil inductance [uH]
#-d           Specific fo this slave:
#-d              ROT_INERTIA_GCM2 : Rotor inertia in gcm²
#-d              CTRL_MODE    : Open loop or closed loop or automatic
#-d                     Auto   = 0   :  Open loop for low velos and closed loop on high velos
#-d                     Open   = 1   :  Open loop all the time, default
#-d                     Closed = 2   :  Closed loop all the time
#-d              VELO_THRSHLD : If control mode is auto the control will switch between open and closed loop at this velo (UNIT deg/s)
#-d              CURR_RED_DLY_S : Current reduction delay time for open loop (default 0.2s) unit [s]
#-d              COMMUTATION    : Commutation settings
#-d                        Always    = 0
#-d                        Automatic = 1
#-d                        Off       = 2  (default)
#-d              CSX_MODE     : CSP,CSV or CST mode. Defaults to CSV
#-d              NOM_RPM      : Nominal RPM, defaults to 4000 
#-d              MAX_RPM      : Nominal RPM, defaults to 4000
#-d              CIA402_POS   : CiA402 pos unit (see festo manual)
#-d              CIA402_VEL   : CiA402 vel unit (see festo manual)
#-d              CIA402_ACC   : CiA402 acc unit (see festo manual)
#-d              CIA402_JERK  : CiA402 jerk unit (see festo manual)
#-d              CIA402_UNIT  : CiA402 unit :
#-d                    0 : Internal increments inc/s ..
#-d                    1 : Increments inc/s ..
#-d                    2 : Rev, rev/s
#-d                    3 : Rev, rev/min
#-d                    4 : Rad, rad/s
#-d                    5 : Deg, deg/s (default in ecmccomp)
#-d                    6 : Metric m m/s
#-d                    7 : Imperial in in/s
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"2PH_STEPPER")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"I_MAX_MA,I_STDBY_MA,U_NOM_MV,R_COIL_MOHM,STEPS,INV_DIR,L_COIL_UH,R_COIL_MOHM,ROT_INERTIA_GCM2,CTRL_MODE,VELO_SWITCH_LIM,CURR_RED_DLY_S,COMMUTATION,NOM_RPM,MAX_RPM,CIA402_POS,CIA402_VEL,CIA402_ACC,CIA402_JERK,CIA402_UNIT")

#- Currents
epicsEnvSet(DRV_I_MAX_MA,8000)

#- Voltage
epicsEnvSet(DRV_U_MAX_MV,48000)

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"Festo-CMMT-ST_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")
