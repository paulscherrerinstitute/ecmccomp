#-d /**
#-d   \brief SDOS for BISS C interface of Festo CMMT-ST  
#-d   \details Parametrization of Festo CMMT-ST
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d              CLK_FRQ_KHZ   : Clock frequency (defaults to setting in encoder file)
#-d              INV_DIR       : Invert motor direction (0 = not invert (default), 1 = invert dir)
#-d              MT_BITS       : Multiturn bits
#-d              ST_BITS       : Singleturn bits
#-d              ACTIVATE_CORR : Activate correction table, default 0
#-d              HOMED        : Set encoder to be homed, default 1
#-d */

#- Type
epicsEnvSet(SLAVE_TYPE,"BISS_C_ENC")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"Festo-CMMT-ST_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"CLK_FRQ_KHZ,INV_DIR,MT_BITS,ST_BITS,FORCE_CLK_FRQ_HZ,ACTIVATE_CORR,HOMED")
