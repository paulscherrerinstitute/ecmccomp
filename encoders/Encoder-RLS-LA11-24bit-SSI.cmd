#-d /**
#-d   \brief Script for Encoder-RLS-LA11-24bit
#-d   \details RLS Biss-C 24-bit encoder, encoder sends 26-bit with LSB at 2
#-d   \author Anders Sandström
#-d   \file
#-d   \note Supply:     5 V
#-d   \note Resolution: 24 bit
#-d */

#- Component TYPE []
epicsEnvSet(COMP_TYPE,SSI_ENC)

#- 0x80p8:02: Disable Status Bits (default 0)
epicsEnvSet(ENC_DIS_STAT_BITS,0)

#- 0x80p8:02: Enable power failure Bits (default 0)
epicsEnvSet(ENC_ENA_POW_STAT_BIT,0)

#- 0x80p0:06: Coding (EL5002)
#- 0: Binary code
#- 1: Gray code active
epicsEnvSet(ENC_CODING,0)

#- 0x80p0:09: Clock Frequency [kHz]
epicsEnvSet(ENC_CLK_FRQ_KHZ,1000)

#- 0x80p0:09 SSI frame size [] (data length + stat bits)
epicsEnvSet(ENC_FRM_SIZE,26)

#- SSI data size []
epicsEnvSet(ENC_ST_BITS,24)
