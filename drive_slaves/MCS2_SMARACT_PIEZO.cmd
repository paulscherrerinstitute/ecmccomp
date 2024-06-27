#==============================================================================
# MCS2_SMARACT_PIEZO.cmd
#-d /**
#-d   \brief SDOS for SmaraAct MCS2
#-d   \details Parametrization of EL7047
#-d   \author Anders Sandström
#-d   \file
#-d   \note Max current= 5 A
#-d   \note Max voltage= 48 V
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d              POS_TYPE       : Positioner type
#-d              HOME_VELO      : Homing velocity
#-d              HOME_ACC       : Homing Acceleration
#-d              HOME_METHOD_ID : Homing/referencing method id (defaults to auto = -1). The supported modes can be read from SDO.
#-d              SAFE_DIR       : Set safe direction (0 = forward (default),1 = backward)
#-d              REF_OPTS       : Referencing Options bit-field (see MCS2 manual), not all options are valid for all positioner types
#-d                 bit 0       : Start direction (0 = forward)
#-d                 bit 1       : Reverse direction, only valid for positioners with multi ref-marks, will reverse search dir as sson the first mark is found (0 = not reverse)
#-d                 bit 2       : Auto zero, teh current position is set to zero when finding teh ref pos (this seems to work like this without setting this bit)
#-d                 bit 3       : Abort on endstop
#-d                 bit 4       : Continue motion on reffound (will not stop, must stop manually). Strange option..
#-d                 bit 5       : Stop motion immediately when finding the ref
#-d                 bit 24      : Invalidate home flag
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"MCS2_DRIVE")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"POS_TYPE,HOME_VELO,HOME_ACC,HOME_METHOD_ID,SAFE_DIR,REF_OPTS")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"MCS2_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"3")
