#==============================================================================
# EL5001_SDOS_SSI_ENC.cmd
#-d /**
#-d   \brief SDOS for EL5001 encoder interface
#-d   \details Parametrization of EL5001
#-d   \author Anders Sandström
#-d   \file
#-d */  

#- Calculate SDO adress based on CH (0x8010 for CH1)
epicsEnvSet(SDO_INDEX,"0x80${CH_ID}0")

#- Execute common EL500X 
#- unfortenately EL5001 ch is at 0x8010 while EL5002 ch1 is at 0x8000
< ${ecmccomp_DIR}EL500X_SDOS_${SLAVE_TYPE}.cmd
