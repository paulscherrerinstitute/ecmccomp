#==============================================================================
# EL500X_SDOS_SSI_ENC.cmd
#-d /**
#-d   \brief SDOS for EL5002 encoder interface
#-d   \details Parametrization of EL5002
#-d   \author Anders Sandström
#-d   \file
#-d */  

#- Calculate SDO adress based on CH (0x8000 for CH1, 0x8010 for CH2)
ecmcEpicsEnvSetCalc(CH_ID_M1,"${CH_ID=1}-1")
epicsEnvSet(SDO_INDEX,"0x80${CH_ID_M1}0")
epicsEnvUnset(CH_ID_M1)

#- Execute common EL500X 
#- unfortenately EL5001 ch is at 0x8010 while EL5002 ch1 is at 0x8000
< ${ecmccomp_DIR}EL500X_SDOS_${SLAVE_TYPE}.cmd
