APPEND ~BDENTAR~
IF WEIGHT #-9 ~GlobalLT("BD_plot","global",55) AreaCheck("bd0102") GlobalGT("DS_P1_DROW","GLOBAL",0) Global("DS_SOD_ENTAR","GLOBAL",0)~ THEN BEGIN ds_ent_0
  SAY @103
  IF ~~ THEN REPLY @104 DO ~SetGlobal("DS_SOD_ENTAR","GLOBAL",1)~ GOTO ds_ent_r0
  IF ~~ THEN REPLY @106 DO ~SetGlobal("DS_SOD_ENTAR","GLOBAL",1)~ GOTO ds_ent_r1
  IF ~~ THEN REPLY @108 DO ~SetGlobal("DS_SOD_ENTAR","GLOBAL",1)~ GOTO ds_ent_r2
END
IF ~~ THEN BEGIN ds_ent_r0
  SAY @105
  COPY_TRANS ~BDENTAR~ %ds_ent%
END
IF ~~ THEN BEGIN ds_ent_r1
  SAY @107
  COPY_TRANS ~BDENTAR~ %ds_ent%
END
IF ~~ THEN BEGIN ds_ent_r2
  SAY @109
  COPY_TRANS ~BDENTAR~ %ds_ent%
END
END
