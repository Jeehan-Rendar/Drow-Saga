
BEGIN ~DSSBAE~
BEGIN ~DSSCOR~
BEGIN ~DSSDOR~
BEGIN ~DSSDYN~
BEGIN ~DSSEDW~
BEGIN ~DSSGLI~
BEGIN ~DSSJAH~
BEGIN ~DSSKHA~
BEGIN ~DSSMIN~
BEGIN ~DSSMKH~
BEGIN ~DSSNEE~
BEGIN ~DSSRAS~
BEGIN ~DSSSAF~
BEGIN ~DSSVIC~
BEGIN ~DSSVOG~

APPEND ~DSSCOR~
IF ~Global("DS_S_COR","GLOBAL",1)~ THEN BEGIN ds_dsscor_1_0
  SAY @170
  IF ~~ THEN DO ~SetGlobal("DS_S_COR","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dsscor_1_1
END
IF ~~ THEN BEGIN ds_dsscor_1_1
  SAY @171
  IF ~~ THEN REPLY @172 GOTO ds_dsscor_1_r0
  IF ~~ THEN REPLY @174 GOTO ds_dsscor_1_r1
  IF ~~ THEN REPLY @176 GOTO ds_dsscor_1_r2
END
IF ~~ THEN BEGIN ds_dsscor_1_r0
  SAY @173
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dsscor_1_r1
  SAY @175
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dsscor_1_r2
  SAY @177
  IF ~~ THEN EXIT
END
END

APPEND ~DSSGLI~
IF ~Global("DS_S_GLI","GLOBAL",1)~ THEN BEGIN ds_dssgli_1_0
  SAY @178
  IF ~~ THEN DO ~SetGlobal("DS_S_GLI","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssgli_1_1
END
IF ~~ THEN BEGIN ds_dssgli_1_1
  SAY @179
  IF ~~ THEN REPLY @180 GOTO ds_dssgli_1_r0
  IF ~~ THEN REPLY @182 GOTO ds_dssgli_1_r1
  IF ~~ THEN REPLY @184 GOTO ds_dssgli_1_r2
END
IF ~~ THEN BEGIN ds_dssgli_1_r0
  SAY @181
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssgli_1_r1
  SAY @183
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssgli_1_r2
  SAY @185
  IF ~~ THEN EXIT
END
END

APPEND ~DSSVOG~
IF ~Global("DS_S_VOG","GLOBAL",1)~ THEN BEGIN ds_dssvog_1_0
  SAY @186
  IF ~~ THEN DO ~SetGlobal("DS_S_VOG","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssvog_1_1
END
IF ~~ THEN BEGIN ds_dssvog_1_1
  SAY @187
  IF ~~ THEN REPLY @188 GOTO ds_dssvog_1_r0
  IF ~~ THEN REPLY @190 GOTO ds_dssvog_1_r1
  IF ~~ THEN REPLY @192 GOTO ds_dssvog_1_r2
END
IF ~~ THEN BEGIN ds_dssvog_1_r0
  SAY @189
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssvog_1_r1
  SAY @191
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssvog_1_r2
  SAY @193
  IF ~~ THEN EXIT
END
END

APPEND ~DSSMKH~
IF ~Global("DS_S_MKH","GLOBAL",1)~ THEN BEGIN ds_dssmkh_1_0
  SAY @194
  IF ~~ THEN DO ~SetGlobal("DS_S_MKH","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssmkh_1_1
END
IF ~~ THEN BEGIN ds_dssmkh_1_1
  SAY @195
  IF ~~ THEN REPLY @196 GOTO ds_dssmkh_1_r0
  IF ~~ THEN REPLY @198 GOTO ds_dssmkh_1_r1
  IF ~~ THEN REPLY @200 GOTO ds_dssmkh_1_r2
END
IF ~~ THEN BEGIN ds_dssmkh_1_r0
  SAY @197
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssmkh_1_r1
  SAY @199
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssmkh_1_r2
  SAY @201
  IF ~~ THEN EXIT
END
END

APPEND ~DSSMKH~
IF ~Global("DS_S_MKH","GLOBAL",3)~ THEN BEGIN ds_dssmkh_3_0
  SAY @202
  IF ~~ THEN REPLY @203 DO ~SetGlobal("DS_S_MKH","GLOBAL",4) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssmkh_3_r0
  IF ~~ THEN REPLY @205 DO ~SetGlobal("DS_S_MKH","GLOBAL",4) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssmkh_3_r1
  IF ~~ THEN REPLY @208 DO ~SetGlobal("DS_S_MKH","GLOBAL",4) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssmkh_3_r2
END
IF ~~ THEN BEGIN ds_dssmkh_3_r0
  SAY @204
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssmkh_3_r1
  SAY @206
  IF ~~ THEN GOTO ds_dssmkh_3_r1_1
END
IF ~~ THEN BEGIN ds_dssmkh_3_r1_1
  SAY @207
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssmkh_3_r2
  SAY @209
  IF ~~ THEN EXIT
END
END

APPEND ~DSSBAE~
IF ~Global("DS_S_BAE","GLOBAL",1)~ THEN BEGIN ds_dssbae_1_0
  SAY @210
  IF ~~ THEN REPLY @211 DO ~SetGlobal("DS_S_BAE","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssbae_1_r0
  IF ~~ THEN REPLY @213 DO ~SetGlobal("DS_S_BAE","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssbae_1_r1
  IF ~~ THEN REPLY @215 DO ~SetGlobal("DS_S_BAE","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssbae_1_r2
END
IF ~~ THEN BEGIN ds_dssbae_1_r0
  SAY @212
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssbae_1_r1
  SAY @214
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssbae_1_r2
  SAY @216
  IF ~~ THEN EXIT
END
END

APPEND ~DSSMIN~
IF ~Global("DS_S_MIN","GLOBAL",1)~ THEN BEGIN ds_dssmin_1_0
  SAY @217
  IF ~~ THEN DO ~SetGlobal("DS_S_MIN","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssmin_1_1
END
IF ~~ THEN BEGIN ds_dssmin_1_1
  SAY @218
  IF ~~ THEN REPLY @219 GOTO ds_dssmin_1_r0
  IF ~~ THEN REPLY @221 GOTO ds_dssmin_1_r1
  IF ~~ THEN REPLY @223 GOTO ds_dssmin_1_r2
END
IF ~~ THEN BEGIN ds_dssmin_1_r0
  SAY @220
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssmin_1_r1
  SAY @222
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssmin_1_r2
  SAY @224
  IF ~~ THEN EXIT
END
END

APPEND ~DSSDYN~
IF ~Global("DS_S_DYN","GLOBAL",1)~ THEN BEGIN ds_dssdyn_1_0
  SAY @225
  IF ~~ THEN DO ~SetGlobal("DS_S_DYN","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssdyn_1_1
END
IF ~~ THEN BEGIN ds_dssdyn_1_1
  SAY @226
  IF ~~ THEN REPLY @227 GOTO ds_dssdyn_1_r0
  IF ~~ THEN REPLY @229 GOTO ds_dssdyn_1_r1
  IF ~~ THEN REPLY @231 GOTO ds_dssdyn_1_r2
END
IF ~~ THEN BEGIN ds_dssdyn_1_r0
  SAY @228
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssdyn_1_r1
  SAY @230
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssdyn_1_r2
  SAY @232
  IF ~~ THEN EXIT
END
END

APPEND ~DSSJAH~
IF ~Global("DS_S_JAH","GLOBAL",1)~ THEN BEGIN ds_dssjah_1_0
  SAY @233
  IF ~~ THEN DO ~SetGlobal("DS_S_JAH","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssjah_1_1
END
IF ~~ THEN BEGIN ds_dssjah_1_1
  SAY @234
  IF ~~ THEN REPLY @235 GOTO ds_dssjah_1_r0
  IF ~~ THEN REPLY @237 GOTO ds_dssjah_1_r1
  IF ~~ THEN REPLY @239 GOTO ds_dssjah_1_r2
END
IF ~~ THEN BEGIN ds_dssjah_1_r0
  SAY @236
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssjah_1_r1
  SAY @238
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssjah_1_r2
  SAY @240
  IF ~~ THEN EXIT
END
END

APPEND ~DSSKHA~
IF ~Global("DS_S_KHA","GLOBAL",1)~ THEN BEGIN ds_dsskha_1_0
  SAY @241
  IF ~~ THEN DO ~SetGlobal("DS_S_KHA","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dsskha_1_1
END
IF ~~ THEN BEGIN ds_dsskha_1_1
  SAY @242
  IF ~~ THEN REPLY @243 GOTO ds_dsskha_1_r0
  IF ~~ THEN REPLY @245 GOTO ds_dsskha_1_r1
  IF ~~ THEN REPLY @247 GOTO ds_dsskha_1_r2
END
IF ~~ THEN BEGIN ds_dsskha_1_r0
  SAY @244
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dsskha_1_r1
  SAY @246
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dsskha_1_r2
  SAY @248
  IF ~~ THEN EXIT
END
END

APPEND ~DSSEDW~
IF ~Global("DS_S_EDW","GLOBAL",1)~ THEN BEGIN ds_dssedw_1_0
  SAY @249
  IF ~~ THEN DO ~SetGlobal("DS_S_EDW","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssedw_1_1
END
IF ~~ THEN BEGIN ds_dssedw_1_1
  SAY @250
  IF ~~ THEN REPLY @251 GOTO ds_dssedw_1_r0
  IF ~~ THEN REPLY @253 GOTO ds_dssedw_1_r1
  IF ~~ THEN REPLY @255 GOTO ds_dssedw_1_r2
END
IF ~~ THEN BEGIN ds_dssedw_1_r0
  SAY @252
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssedw_1_r1
  SAY @254
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssedw_1_r2
  SAY @256
  IF ~~ THEN EXIT
END
END

APPEND ~DSSSAF~
IF ~Global("DS_S_SAF","GLOBAL",1)~ THEN BEGIN ds_dsssaf_1_0
  SAY @257
  IF ~~ THEN DO ~SetGlobal("DS_S_SAF","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dsssaf_1_1
END
IF ~~ THEN BEGIN ds_dsssaf_1_1
  SAY @258
  IF ~~ THEN REPLY @259 GOTO ds_dsssaf_1_r0
  IF ~~ THEN REPLY @261 GOTO ds_dsssaf_1_r1
  IF ~~ THEN REPLY @263 GOTO ds_dsssaf_1_r2
END
IF ~~ THEN BEGIN ds_dsssaf_1_r0
  SAY @260
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dsssaf_1_r1
  SAY @262
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dsssaf_1_r2
  SAY @264
  IF ~~ THEN EXIT
END
END

APPEND ~DSSNEE~
IF ~Global("DS_S_NEE","GLOBAL",1)~ THEN BEGIN ds_dssnee_1_0
  SAY @265
  IF ~~ THEN DO ~SetGlobal("DS_S_NEE","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssnee_1_1
END
IF ~~ THEN BEGIN ds_dssnee_1_1
  SAY @266
  IF ~~ THEN REPLY @267 GOTO ds_dssnee_1_r0
  IF ~~ THEN REPLY @269 GOTO ds_dssnee_1_r1
  IF ~~ THEN REPLY @271 GOTO ds_dssnee_1_r2
END
IF ~~ THEN BEGIN ds_dssnee_1_r0
  SAY @268
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssnee_1_r1
  SAY @270
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssnee_1_r2
  SAY @272
  IF ~~ THEN EXIT
END
END

APPEND ~DSSRAS~
IF ~Global("DS_S_RAS","GLOBAL",1)~ THEN BEGIN ds_dssras_1_0
  SAY @273
  IF ~~ THEN DO ~SetGlobal("DS_S_RAS","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssras_1_1
END
IF ~~ THEN BEGIN ds_dssras_1_1
  SAY @274
  IF ~~ THEN REPLY @275 GOTO ds_dssras_1_r0
  IF ~~ THEN REPLY @277 GOTO ds_dssras_1_r1
  IF ~IsValidForPartyDialogue("VICONIA")~ THEN REPLY @279 GOTO ds_dssras_1_r2
  IF ~!IsValidForPartyDialogue("VICONIA")~ THEN REPLY @281 GOTO ds_dssras_1_r3
END
IF ~~ THEN BEGIN ds_dssras_1_r0
  SAY @276
  IF ~~ THEN REPLY @277 GOTO ds_dssras_1_r1
  IF ~IsValidForPartyDialogue("VICONIA")~ THEN REPLY @279 GOTO ds_dssras_1_r2
  IF ~!IsValidForPartyDialogue("VICONIA")~ THEN REPLY @281 GOTO ds_dssras_1_r3
END
IF ~~ THEN BEGIN ds_dssras_1_r1
  SAY @278
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssras_1_r2
  SAY @280
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssras_1_r3
  SAY @282
  IF ~~ THEN EXIT
END
END

APPEND ~DSSDOR~
IF ~Global("DS_S_DOR","GLOBAL",1)~ THEN BEGIN ds_dssdor_1_0
  SAY @283
  IF ~~ THEN REPLY @284 DO ~SetGlobal("DS_S_DOR","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssdor_1_r0
  IF ~~ THEN REPLY @286 DO ~SetGlobal("DS_S_DOR","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssdor_1_r1
  IF ~~ THEN REPLY @288 DO ~SetGlobal("DS_S_DOR","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssdor_1_r2
END
IF ~~ THEN BEGIN ds_dssdor_1_r0
  SAY @285
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssdor_1_r1
  SAY @287
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssdor_1_r2
  SAY @289
  IF ~~ THEN EXIT
END
END

APPEND ~DSSVIC~
IF ~Global("DS_S_VIC","GLOBAL",1)~ THEN BEGIN ds_dssvic_1_0
  SAY @290
  IF ~~ THEN DO ~SetGlobal("DS_S_VIC","GLOBAL",2) SetGlobalTimer("DS_D_GAP","GLOBAL",EIGHT_HOURS)~ GOTO ds_dssvic_1_1
END
IF ~~ THEN BEGIN ds_dssvic_1_1
  SAY @291
  IF ~IsValidForPartyDialogue("MINSC")~ THEN REPLY @292 GOTO ds_dssvic_1_r0
  IF ~!IsValidForPartyDialogue("MINSC")~ THEN REPLY @294 GOTO ds_dssvic_1_r1
  IF ~~ THEN REPLY @296 GOTO ds_dssvic_1_r2
  IF ~~ THEN REPLY @298 GOTO ds_dssvic_1_r3
END
IF ~~ THEN BEGIN ds_dssvic_1_r0
  SAY @293
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssvic_1_r1
  SAY @295
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssvic_1_r2
  SAY @297
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_dssvic_1_r3
  SAY @299
  IF ~~ THEN EXIT
END
END

