#-d /**
#-d   \brief hardware script for Smaract generic stage
#-d   \details Parametrization of Smaract generic stage
#-d   \author Anders Sandström
#-d   \file
#-d
#-d   \note 
#-d   The POS_TYPE macro must be set when calling applyComponent.cmd using this 
#-d   generic cfg since MOT_POS_TYPE is set to a none valid number(must be overridden)
#-d */

#- Component TYPE []
epicsEnvSet(COMP_TYPE,SMARACT_PIEZO)

#- Positioner type (look in smaract docs). NOT VALID.. MUST BE OVERRIDDEN
epicsEnvSet(MOT_POS_TYPE,-1)

#- Homing velo [um/s or udeg/s]
epicsEnvSet(MOT_HOME_VELO,1000)

#- Homing acc [um/s2 or udeg/s2]
epicsEnvSet(MOT_HOME_ACC,1000)

#- Homing method id []
epicsEnvSet(MOT_HOME_METHOD_ID,-1)

#- Supported homing
#- sandst_a@c6025a:~$ ethercat upload --type int8 -m1 -p0 0x60e3 1  
#- 0xffffff80 -128
#- sandst_a@c6025a:~$ ethercat upload --type int8 -m1 -p0 0x60e3 2
#- 0xffffff81 -127
#- sandst_a@c6025a:~$ ethercat upload --type int8 -m1 -p0 0x60e3 3
#- 0xffffff82 -126
#- sandst_a@c6025a:~$ ethercat upload --type int8 -m1 -p0 0x60e3 4
#- 0xffffff83 -125
#- sandst_a@c6025a:~$ ethercat upload --type int8 -m1 -p0 0x60e3 5
#- 0xffffff88 -120
#- sandst_a@c6025a:~$ ethercat upload --type int8 -m1 -p0 0x60e3 6
#- 0xffffff89 -119
#- sandst_a@c6025a:~$ ethercat upload --type int8 -m1 -p0 0x60e3 7
#- 0xffffff8a -118
#- sandst_a@c6025a:~$ ethercat upload --type int8 -m1 -p0 0x60e3 8
#- 0xffffff8b -117
#- sandst_a@c6025a:~$ ethercat upload --type int8 -m1 -p0 0x60e3 9
#- 0x01 1
#- sandst_a@c6025a:~$ ethercat upload --type int8 -m1 -p0 0x60e3 10
#- 0x02 2
#- sandst_a@c6025a:~$ ethercat upload --type int8 -m1 -p0 0x60e3 11
#- 0x25 37
#- for some reason 0x60e3 12 does not exists
#-
