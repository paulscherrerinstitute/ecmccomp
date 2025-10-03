#==============================================================================
# EL7411_SDOS_BLDC.cmd
#-d /**
#-d   \brief SDOS for EL7411 drive
#-d   \details Parametrization of EL7411
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Current loop I default 10 = 1ms [0.1ms]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x12,${CURR_TI=${MOT_CURR_TI=10}},2)"
#- Current loop P (0.1V/A) default 10 = 1V/A [0.1V/A]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x13,${CURR_KP=${MOT_CURR_KP=10}},2)"

#- Velocity loop proportianal gain = 20 
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x15,${VELO_KP=${MOT_VELO_KP=20}},4)"
#- Velocity loop integral time = 50 =5ms [0.1ms]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x14,${VELO_TI=${MOT_VELO_TI=50}},4)"

#- Nominal voltage = 48V
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x19,${U_NOM_MV_VALID},4)"

#- Commutation Find cummutation time default 9 = 0.9ms
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x63,${COM_TIME=${MOT_COM_TIME=9}},2)"
#- Commutation type FOC with incremental encoder =1
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x64,${COM_TYPE=${MOT_COM_TYPE=1}},1)"

#- Motor max current = 12000
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x11,${I_MAX_MA_VALID},4)"
#- Motor rated current = 4A
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x12,${MOT_I_NOM_MA},4)"

#- Motor pole pairs = 1
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x13,${MOT_POLE_PAIRS=1},1)"

#- Torque contstant = 50mNm/A
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x16,${MOT_TRQ_CONST_MNM_P_A=50},4)"
#- Rotor moment of inertia = 101
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x18,${MOT_ROT_INERTIA_GCM2=100},4)"

#- Winding inductance = 0.204mH (unit in setting 0.01mH)
ecmcEpicsEnvSetCalc(L_COIL_TEMP,"${MOT_L_COIL_UH}*0.1","%d")
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x19,${L_COIL_TEMP},2)"
epicsEnvUnset(L_COIL_TEMP)

#- Motor speed limitation = 11000
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x1b,${MOT_VELO_LIM},4)"

#- Rated voltage = 48V (48000mV)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x2F,${U_NOM_MV_VALID},4)"

#- Winding resistance 1.03 ohm (1030mOhm)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x30,${MOT_R_COIL_MOHM},4)"

#- Voltage constant:  1/231=0.00432 volt/rpm
#ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x31,4320,4)"

#- Motor thermal time constant = 3.96 s for WINDING!!
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x2d,${MOT_THERM_CONST},2)"

#- Settings done
ecmcConfig "Cfg.EcSetSlaveSDOSettingsDone(${COMP_S_ID},${CH_ID=1},1)"
