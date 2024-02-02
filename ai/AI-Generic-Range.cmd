#-d /**
#-d   \brief Script for AI-Generic-Range
#-d   \details
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Component TYPE []
epicsEnvSet(COMP_TYPE,MULTI_AI)

#- Set range
epicsEnvSet(AI_RANGE,"+-10V")
