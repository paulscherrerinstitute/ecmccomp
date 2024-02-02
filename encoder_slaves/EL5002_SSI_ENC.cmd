#-d /**
#-d   \brief SDOS for EL5002 
#-d   \details Parametrization of EL5002 2CH SSI encoder interface
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d              CLK_FRQ_KHZ       : Clock frequency in KHz (defaults to setting in encoder file), closest possible setting will be set
#-d              CODING            : 0 = Binary coding, 1 = Gray coding
#-d              DIS_STAT_BITS     : Disable status bits
#-d              ENA_POW_STAT_BIT  : Enable power status bit
#-d              FRM_SIZE          : Total frame size [bits]
#-d              ST_BITS           : Data bits [bits]
#-d */

#- Type
epicsEnvSet(SLAVE_TYPE,"SSI_ENC")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL5002_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"2")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"CLK_FRQ_KHZ,CODING,DIS_STAT_BITS,ENA_POW_STAT_BIT,FRM_SIZE,ST_BITS")
