#==============================================================================
# validateGeneric.cmd
#-d /**
#-d   \brief Common script for validation
#-d   \author Anders Sandström
#-d   \file

#-===== Validate CHANNEL ===
ecmcEpicsEnvSetCalcTernary(DIE,"${CH_ID=1}>${SLAVE_CHANNELS}","", "#-")
${DIE}ecmcExit Error: CHANNEL out of range (not supported by the slave). 
epicsEnvUnset(DIE)
