#-d /**
#-d   \brief hardware script for generic 2 phase stepper
#-d   \details Parametrization generic 2 phase stepper
#-d   \author Anders Sandström
#-d   \note 
#-d   The follow macros are optional:
#-d              I_KP         : Current loop gain
#-d              I_TI         : Current loop integration time
#-d              V_KP         : Velocity loop gain
#-d              V_TI         : Velocity loop integration time
#-d              P_KP         : Position loop gain
#-d              R_COIL_MOHM  : Coil resistance in mOhm
#-d              L_COIL_UH    : Coil inductance in uH
#-d */
#- Component TYPE []

epicsEnvSet(COMP_TYPE,CTRL_PARAMS)
