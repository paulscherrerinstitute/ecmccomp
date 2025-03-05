#==============================================================================
# EL2522_STEP_DIR.cmd
#-d /**
#-d   \brief SDOS for EL2522 step direction drive (encoder simulation terminal)
#-d   \details Parametrization of EL2522
#-d   \author Anders Sandström
#-d   \file
#-d   \param MACROS         (optional) Special macros, depending on component/slave type:
#-d          STEP_DIR    (general Step direction cfg):
#-d              FREQ_SCALE     : Frequency setpoint scaling, output will scale with this value.
#-d                               Setting to 1 means that the frequency output will be want you send example (1000 velo setpoint will result in 1kHz pulse train)
#-d                               Setting to 0.1 means that the frequency output will be want you send example (1000 velo setpoint will result in 100Hz pulse train)
#-d              MAX_FREQ       : Max output frequency (default 10000Hz), No higher freq than this will be outputed
#-d */

#- Drive type
epicsEnvSet(SLAVE_TYPE,"STEP_DIR")

#- Supported macros
epicsEnvSet(SUPP_MACROS,"FREQ_SCALE,MAX_FREQ")

#- SDOS script
epicsEnvSet(SLAVE_SCRIPT,"EL2522_SDOS")

#- Channel count
epicsEnvSet(SLAVE_CHANNELS,"2")
