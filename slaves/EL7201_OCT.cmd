#-d /**
#-d   \brief SDOS for EL7201 drive OCT
#-d   \details Parametrization of EL7201
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 5.7 A
#-d   \note Max voltage= 48 V
#-d */

#- Apply common for EL7201
ecmcFileExist("${ecmccomp_DIR}EL7201_XXX.cmd",1,1)
< ${ecmccomp_DIR}EL7201_XXX.cmd.cmd

#- Apply common for OCT
ecmcFileExist("${ecmccomp_DIR}EL72XX_OCT.cmd",1,1)
< ${ecmccomp_DIR}EL72XX_XXX.cmd
