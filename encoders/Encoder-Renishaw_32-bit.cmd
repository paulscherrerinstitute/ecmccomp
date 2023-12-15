#-d /**
#-d   \brief Script for Encoder-Renishaw-32bit.cmd
#-d   \details
#-d   \author Anders Sandström
#-d   \file
#-d   \note Supply:     5 V
#-d   \note Resolution: 32 bit TBD
#-d */

#- Component TYPE []
epicsEnvSet(COMP_TYPE,BISS_C_IF)

#- 0x80p8:02: Disable Status Bits (default 0)
epicsEnvSet(ENC_DIS_STAT_BITS,0)

#- 0x80p8:03: CRC Invert (default 1 ?)
epicsEnvSet(ENC_CRC_INV,1)

#- 0x80p8:11: CRC Polynom (default 67)
epicsEnvSet(ENC_CRC_POLY,67)

#- 0x80p8:12: Supply voltage
#- 50: 5V (default)
#- 90: 9V
epicsEnvSet(ENC_U_SUP_VLT,50)

#- 0x80p8:13: Clock Frequency
#- 0: 10 MHz (default)
#- 1: 5 MHz
#- 2: 3.33 MHz
#- 3: 2.5 MHz
#- 4: 2 MHz
#- 9: 1 MHz (Max for SSI)
#- 17: 500 kHz
#- 19: 250 kHz
epicsEnvSet(ENC_CLK_FRQ,9)

#- 0x80p8:14: Coding
#- 0: Dual code active (default)
#- 1: Gray code active
epicsEnvSet(ENC_CODEING,0)

#- 0x80p8:15: Multiturn [Bit] Number of multiturn bits
#- default 12
epicsEnvSet(ENC_MT_BITS,0)

#- 0x80p8:16: Singleturn [Bit] Number of singleturn bits
#- default 13
epicsEnvSet(ENC_ST_BITS,32)

#- 0x80p8:17: Offset LSB Bit [Bit] Number of “right aligned” Offset bits
#- default 0
epicsEnvSet(ENC_LSB_OFF_BITS,32)
