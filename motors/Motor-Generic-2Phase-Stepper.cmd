#-d /**
#-d   \brief hardware script for generic 2 phase stepper
#-d   \details Parametrization generic 2 phase stepper
#-d   \author Anders Sandström
#-d   \note 
#-d   The follow macros are needed to be overriden when using this generic cfg:
#-d   * I_MAX_MA:     max current in mA
#-d   * I_STDBY_MA:   stdby current in mA
#-d   * R_COIL_MOHM:  Coil resistance in mOhm
#-d   * L_COIL_UH:    Coil inductance in uH (neded for some drives)
#-d   optional:
#-d   *  U_MAX_MV:    Supply voltage in mV (24000 or 48000 normally)
#-d */

#- Component TYPE []
epicsEnvSet(COMP_TYPE,2PH_STEPPER)

#- Max Current [mA]
epicsEnvSet(MOT_I_MAX_MA,-1)

#- Standby Current [mA] (30% of max)
epicsEnvSet(MOT_I_STDBY_MA,-1)

#- Max Voltage [mV]
epicsEnvSet(MOT_U_MAX_MV,48000)

#- Motor Voltage at MOT_I_MAX_MA [mV]
epicsEnvSet(MOT_U_MV,-1)

#- Phase resistance [mOhm]
epicsEnvSet(MOT_R_COIL_MOHM,-1)

#- Phase inductance [uH]
epicsEnvSet(MOT_L_COIL_UH,-1)

#- Max Torque [mNm]
epicsEnvSet(MOT_TRQ_MAX_NMM,0)

#- EMF [mV/(rad/s)], used for EL7041, set to 0 if unknown
epicsEnvSet(MOT_EMF,0)

#- Motor steps []
epicsEnvSet(MOT_STEPS,200)

#- Rotor Inertia [gcm²]
epicsEnvSet(MOT_ROT_INERTIA_GCM2,0)
