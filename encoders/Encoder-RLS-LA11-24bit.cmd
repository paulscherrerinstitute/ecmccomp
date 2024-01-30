#-d /**
#-d   \brief Script for Encoder-RLS-LA11-24bit
#-d   \details RLS Biss-C 24-bit encoder, encoder sends 26-bit with LSB at 2
#-d   \author Anders Sandström
#-d   \file
#-d   \note Supply:     5 V
#-d   \note Resolution: 24 bit
#-d */

#- Component TYPE []
epicsEnvSet(COMP_TYPE,BISS_C_ENC)

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

#- 0x80p8:13: Clock Frequency [kHz]
epicsEnvSet(ENC_CLK_FRQ_KHZ,2500)

#- 0x80p8:14: Coding
#- 0: Dual code active (default)
#- 1: Gray code active
epicsEnvSet(ENC_CODEING,0)

#- 0x80p8:15: Multiturn [Bit] Number of multiturn bits
#- default 12
epicsEnvSet(ENC_MT_BITS,0)

#- 0x80p8:16: Singleturn [Bit] Number of singleturn bits
#- default 13
epicsEnvSet(ENC_ST_BITS,26)

#- 0x80p8:17: Offset LSB Bit [Bit] Number of “right aligned” Offset bits
#- default 0
epicsEnvSet(ENC_LSB_OFF_BITS,0)
