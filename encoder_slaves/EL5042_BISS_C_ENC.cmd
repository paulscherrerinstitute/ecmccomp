#-d /**
#-d   \brief SDOS for EL5042 
#-d   \details Parametrization of EL5042 2CH BISS-C encoder interface
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d              CLK_FRQ_KHZ  : Clock frequency in KHz (defaults to setting in encoder file), closest possible setting will be set
#-d              INV_DIR      : Invert encoder direction (0 = not invert (default), 1 = invert dir)
#-d              MT_BITS      : Multiturn bits
#-d              ST_BITS      : Singleturn bits
#-d */

#- Type
epicsEnvSet(SLAVE_TYPE,"BISS_C_ENC")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL5042_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"2")

#- Supported macros
#- epicsEnvSet(SUPP_MACROS,"CLK_FRQ_KHZ,INV_DIR,U_SUP_VLT,CODING,MT_BITS,ST_BITS,OFF_BITS,CRC_INV,DIS_STAT_BITS,CRC_POLY")
#- Remove U_SUP_VLT for now.. see SDO file for comments (EL5042 setting applies to both channels, hard to manage here in a safe way)
epicsEnvSet(SUPP_MACROS,"CLK_FRQ_KHZ,INV_DIR,CODING,MT_BITS,ST_BITS,OFF_BITS,CRC_INV,DIS_STAT_BITS,CRC_POLY")
