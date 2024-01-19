#-d /**
#-d   \brief SDOS for EX72XX RES drive
#-d   \details Parametrization of EX72XX Resolver
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Nominal voltage
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x19,${U_NOM_MV_VALID},4)"
epicsEnvUnset(U_NOM_MV_VALID)

#- Motor max current
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x11,${I_MAX_MA_VALID},4)"
epicsEnvUnset(I_MAX_MA_VALID)

#- Motor rated current
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x12,${I_NOM_MA=${MOT_I_NOM_MA}},4)"
epicsEnvUnset(MOT_I_NOM_MA)
epicsEnvUnset(I_NOM_MA)

#- Motor pole pairs
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x13,${MOT_POLE_PAIRS},1)"
epicsEnvUnset(MOT_POLE_PAIRS)

#- Torque contstant
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x16,${MOT_TRQ_CONST_MNM_P_A},4)"
epicsEnvUnset(MOT_TRQ_CONST_MNM_P_A)

#- Winding inductance
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x19,${MOT_L_COIL},2)"
epicsEnvUnset(MOT_L_COIL)

#- Commutation offset
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x15,${MOT_COM_OFFSET_DEG},2)"
epicsEnvUnset(MOT_COM_OFFSET_DEG)

#- Motor thermal time constant [0.1s]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x2d,${MOT_THERM_CONST},2)"
epicsEnvUnset(MOT_THERM_CONST)

#- Motor speed limitation
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x1b,${MOT_VELO_LIM},4)"
epicsEnvUnset(MOT_VELO_LIM)

#- Current loop proportianal gain [0.1 V/A]
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x13,${CURR_KP=${MOT_CURR_KP}},2)"
epicsEnvUnset(MOT_CURR_KP)
epicsEnvUnset(CURR_KP)

#- Current loop integral time
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x12,${CURR_TI=${MOT_CURR_TI}},2)"
epicsEnvUnset(MOT_CURR_TI)
epicsEnvUnset(CURR_TI)

#- Velocity loop proportianal gain
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x15,${VELO_KP=${MOT_VELO_KP}},4)"
epicsEnvUnset(MOT_VELO_KP)
epicsEnvUnset(VELO_KP)

#- Velocity loop integral time
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8010,0x14,${VELO_TI=${MOT_VELO_TI}},4)"
epicsEnvUnset(MOT_VELO_TI)
epicsEnvUnset(VELO_TI)

#- Rotor moment of inertia ( Differs with brake:)
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8011,0x18,${MOT_ROT_INERTIA_GCM2},4)"
epicsEnvUnset(MOT_ROT_INERTIA_GCM2)

#- Brake Application delay
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8012,0x12,${BRK_APP_DLY=${MOT_BRK_APP_DLY=0}},2)"
epicsEnvUnset(BRK_APP_DLY)
epicsEnvUnset(MOT_BRK_APP_DLY)

#- Brake Release delay
ecmcConfigOrDie "Cfg.EcAddSdo(${COMP_S_ID},0x8012,0x11,${BRK_REL_DLY=${MOT_BRK_REL_DLY=0}},2)"
epicsEnvUnset(BRK_REL_DLY)
epicsEnvUnset(MOT_BRK_REL_DLY)
