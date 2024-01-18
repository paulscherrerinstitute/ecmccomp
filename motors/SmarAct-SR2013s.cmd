#-d /**
#-d   \brief hardware script for Smaract SR2013s rotational stage
#-d   \details Parametrization of Smaract SR2013s rotational stage
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Component TYPE []
epicsEnvSet(COMP_TYPE,SMARACT_PIEZO)

#- Positioner type (look in smaract docs)
epicsEnvSet(MOT_POS_TYPE,309)

#- Homing velo [um/s or udeg/s]
epicsEnvSet(MOT_HOME_VELO,1000)

#- Homing velo [um/s2 or udeg/s2]
epicsEnvSet(MOT_HOME_VELO,1000)

#- Homing method id []
epicsEnvSet(MOT_HOME_METHOD_ID,-128)
