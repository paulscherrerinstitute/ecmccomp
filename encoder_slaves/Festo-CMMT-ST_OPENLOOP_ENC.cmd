#-d /**
#-d   \brief SDOS for Open loop interface of Festo CMMT-ST  
#-d   \details Parametrization of Festo CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d              INV_DIR       : Invert motor direction (0 = not invert (default), 1 = invert dir)
#-d              HOMED         : Set encoder to be homed, default 1
#-d */

#- Type
epicsEnvSet(SLAVE_TYPE,"OPENLOOP_ENC")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"Festo-CMMT-ST_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"INV_DIR,HOMED")
