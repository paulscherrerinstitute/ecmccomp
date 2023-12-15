#-d /**
#-d   \brief SDOS for EX72XX RES drive
#-d   \details Parametrization of EX72XX Resolver
#-d   \author Anders Sandström
#-d   \file
#-d */

#- Nominal voltage
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x19,${U_NOM_MV},4)"

#- Motor max current
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8011,0x11,${I_MAX_MA},4)"

#- Motor rated current
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8011,0x12,${MOT_I_NOM_MA},4)"

#- Motor pole pairs
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8011,0x13,${MOT_POLE_PAIRS},1)"

#- Torque contstant
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8011,0x16,${MOT_TRQ_CONST},4)"

#- Winding inductance
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8011,0x19,${MOT_L_COIL},2)"

#- Commutation offset
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8011,0x15,${MOT_COM_OFFSET_DEG},2)"

#- Motor thermal time constant [0.1s]
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8011,0x2d,${MOT_THERM_CONST},2)"

#- Motor speed limitation
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8011,0x1b,${MOT_VELO_LIM},4)"

#- Current loop proportianal gain [0.1 V/A]
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x13,${CURR_KP=${MOT_CURR_KP}},2)"

#- Current loop integral time
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x12,${CURR_TI=${MOT_CURR_TI}},2)"

#- Velocity loop proportianal gain
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x15,${VELO_KP=${MOT_VELO_KP}},4)"

#- Velocity loop integral time
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x14,${VELO_TI=${MOT_VELO_TI}},4)"

#- Rotor moment of inertia ( Differs with brake:)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8011,0x18,${MOT_ROT_INERTIA},4)"

#- Brake Application delay
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8012,0x12,${BRK_APP_DLY=${MOT_BRK_APP_DLY=0}},2)"

#- Brake Release delay
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8012,0x11,${BRK_REL_DLY=${MOT_BRK_REL_DLY=0}},2)"
