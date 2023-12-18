#-d /**
#-d   \brief hardware script for Motor-OrientalMotor-PK267JB-Parallel
#-d   \details Parametrization of motor Oriental Motor PK267JB
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 2A / "half" phase => 4A for Parallel
#-d   \note Max voltage= 48V
#-d   \note Inductance per phase = 3.54mH / "half" phase => 1.77mH for parallel
#-d   \note Resistance = 2.4 Ohm / "half" phase => 1.2 Ohm for parallel
#-d */

#- Use Motor-OrientalMotor-PK267JB-Series as base cfg
< ${ecmccomp_DIR}Motor-OrientalMotor-PK267JB-Series.cmd

#- Component TYPE []
epicsEnvSet(COMP_TYPE,2PH_STEPPER)

#- Max Current [mA]
epicsEnvSet(MOT_I_MAX_MA,4000)

#- Phase resistance [mOhm]
epicsEnvSet(MOT_R_COIL_MOHM,1200)

#- Phase inductance [uH]
epicsEnvSet(MOT_L_COIL_UH,1770)
