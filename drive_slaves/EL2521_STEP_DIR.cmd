#==============================================================================
# EL2521_STEP_DIR.cmd
#-d /**
#-d   \brief SDOS for EL2521 step direction drive (encoder simulation terminal)
#-d   \details Parametrization of EL2521
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d          STEP_DIR    (general Step direction cfg):
#-d              FREQ_RES       : Frequency setpoint resolution, output will scale with this value.
#-d                               Setting to 1 means that the frequency output will be want you send example (1000 velo setpoint will result in 1kHz pulse train)
#-d                               Setting to 0.1 means that the frequency output will be want you send example (1000 velo setpoint will result in 100Hz pulse train)
#-d                               NOTE: If FREQ_RES value is changed, also the drvie scaaling in the axis configuration needs to be changed. 
#-d              MAX_FREQ       : Max output frequency (default 10000Hz), No higher freq than this will be outputed
#-d                               NOTE: If MAX_FREQ value is changed, its good practice to ensure that all velocity values in the axis configuration still are valid.
#-d
#-d   \note  MAX_FREQ/FREQ_RES must be less than 32768 (the setpoint is +-15bit)
#-d
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"STEP_DIR")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"FREQ_RES,MAX_FREQ")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL2521_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"1")
