#==============================================================================
# EL9227-5500_OVER_CURR_PROT.cmd
#-d /**
#-d   \brief SDOS for EL9227-5500 over current protection
#-d   \details Parametrization of EL9227-5500, 2CH, 24V, max 10A (sum of both channels)
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 10 A (sum of both channels)
#-d   \note Max voltage= 24 V
#-d   \param MACROS
#-d          OVER_CURR_PROT
#-d              I_MAX_MA     : Fuse current [mA], NOTE: the setting will be converted to integer Amps
#-d */

#- Calculate SDO adress based on CH (0x8000 for CH1, 0x8010 for CH2)
ecmcEpicsEnvSetCalc(CH_ID_M1,"${CH_ID=1}-1")
epicsEnvSet(SDO_INDEX,"0x80${CH_ID_M1}0")
epicsEnvUnset(CH_ID_M1)

#- 0x80x0:0x11: Nominal current
#-  Default in terminal:
#-  * Ch 0: 4A
#-  * Ch 1: 2A
# Convert to integer amps
ecmcEpicsEnvSetCalc(PROT_CURR_AMPS,"${I_MAX_MA=0}/1000","%d")
ecmcConfigOrDie "Cfg.EcAddSdoDT(${COMP_S_ID},$(SDO_INDEX),0x11,$(PROT_CURR_AMPS=0),U8)"
epicsEnvUnset(PROT_CURR_AMPS)
epicsEnvUnset(SDO_INDEX)
