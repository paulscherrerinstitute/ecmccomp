#-d /**
#-d   \brief hardware script for Smaract SLC1750ds linear stage
#-d   \details Parametrization of Smaract SLC1750ds linear stage
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Component TYPE []
epicsEnvSet(COMP_TYPE,SMARACT_PIEZO)

#- Positioner type (look in smaract docs)
epicsEnvSet(MOT_POS_TYPE,300)

#- Homing velo [um/s or udeg/s]
epicsEnvSet(MOT_HOME_VELO,1000)

#- Homing acc [um/s2 or udeg/s2]
epicsEnvSet(MOT_HOME_ACC,1000)

#- Homing method id []
epicsEnvSet(MOT_HOME_METHOD_ID,-128)
