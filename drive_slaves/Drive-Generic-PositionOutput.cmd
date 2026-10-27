#-d /**
#-d   \brief Drive-side periodic position output (currently Nanotec N6).
#-d   \param FULL_STEPS Pulse interval in full steps, default 100.
#-d   \param OUTPUT Physical output 1..3, default 1.
#-d   \param ARM Initial output gate, 0/1, default 0.
#-d   \param N6_IO_24V Shared I/O level: 0=5 V, 1=24 V/+UB_Logic.
#-d                    Defaults to 0 (5 V) for the first output; later outputs inherit it.
#-d   \param N6_INPUT_PULLUP Shared input bias: 0=pull-down, 1=pull-up.
#-d                         Defaults to the motor choice (motor default 0).
#-d   \details Apply after the motor, before EtherCAT configuration is applied.
#-d */
epicsEnvSet(COMP_TYPE,POSITION_OUTPUT)
