#-d /**
#-d   \brief Drive-side time-based PWM output (currently Nanotec N6).
#-d   \param FREQUENCY_HZ Integer carrier frequency 50..2000 Hz, default 2000.
#-d   \param DUTY_PERCENT Integer duty 0..100 percent, default 50.
#-d   \param OUTPUT Physical output 1..3, default 1.
#-d   \param PWM_ID PWM generator 0 or 1, default 0.
#-d   \param ARM Initial gate 0/1, default 0.
#-d   \param N6_IO_24V Shared I/O voltage 0=5 V (first-output default), 1=24 V/+UB_Logic.
#-d   \param N6_INPUT_PULLUP Shared bias 0=pull-down, 1=pull-up; inherit motor.
#-d   \details Apply after the motor and N6_OPT, before EtherCAT configuration.
#-d            PWM is time-based; it is not a position divider.
#-d */
epicsEnvSet(COMP_TYPE,PWM_OUTPUT)
