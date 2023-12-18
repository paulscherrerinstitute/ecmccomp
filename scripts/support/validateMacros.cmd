#==============================================================================
# validateMacros.cmd
#- Arguments: MACROS SUPP_MACROS
#-d /**
#-d   \brief Script for validating used user macros
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS User macros 
#-d   \param SUPP_MACROS   Supported macros
#-d
#-d   \note Example calls:
#-d   \code
#-d     ${SCRIPTEXEC} ${ecmccomp_DIR}validateMacros.cmd, "MACROS='${MACROS}',SUPP_MACROS='I_RUN'"
#-d */

ecmcFileExist(${ecmccomp_DIR}validateMacros.sh,1,1)
system "bash ${ecmccomp_DIR}validateMacros.sh '${MACROS}' '${SUPP_MACROS}' ${ECMC_TMP_DIR}validMacros.cmd"
ecmcFileExist(${ECMC_TMP_DIR}validMacros.cmd,1,1)
< ${ECMC_TMP_DIR}validMacros.cmd
system "rm ${ECMC_TMP_DIR}validMacros.cmd"
