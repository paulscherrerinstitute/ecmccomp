#-d /**
#-d   \brief SDOS for EL5042 
#-d   \details Parametrization of EL5042 2CH BISS-C encoder interface
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d              CLK_FRQ      : Clock frequency (defaults to setting in encoder file)
#-d              INV_DIR      : Invert motor direction (0 = not invert (default), 1 = invert dir)
#-d */

#- Type
epicsEnvSet(SLAVE_TYPE,"BISS_C_ENC")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL5042_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"2")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"CLK_FRQ,INV_DIR,U_SUP_VLT,CODEING,MT_BITS,OFF_BITS,CRC_INV,DIS_STAT_BITS,CRC_POLY")
