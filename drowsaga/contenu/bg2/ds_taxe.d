APPEND ~CIVIL02~
IF WEIGHT #-9 ~CheckSpellState(LastTalkedToBy,DS_DROW_PASSPORT)
Global("DS_TAXE","LOCALS",0)
InParty("Viconia")
See("Viconia")
!StateCheck("Viconia",STATE_SLEEPING)
Global("civil02Viconia","LOCALS",0)~ THEN BEGIN ds_taxe_v
  SAY @152
  IF ~~ THEN DO ~SetGlobal("DS_TAXE","LOCALS",1)
SetGlobal("civil02Viconia","LOCALS",1)~ EXTERN ~VICONIJ~ 76
END
IF WEIGHT #-8 ~CheckSpellState(LastTalkedToBy,DS_DROW_PASSPORT)
Global("DS_TAXE","LOCALS",0)
!InParty("Viconia")~ THEN BEGIN ds_taxe_0
  SAY @145
  IF ~~ THEN REPLY @146 DO ~SetGlobal("DS_TAXE","LOCALS",1)~ GOTO ds_taxe_1
  IF ~~ THEN REPLY @147 DO ~SetGlobal("DS_TAXE","LOCALS",1)~ GOTO ds_taxe_3
  IF ~~ THEN REPLY @148 DO ~SetGlobal("DS_TAXE","LOCALS",1)~ GOTO ds_taxe_4
END
IF ~~ THEN BEGIN ds_taxe_1
  SAY @149
  IF ~PartyGoldGT(9)~ THEN DO ~TakePartyGold(10)~ GOTO ds_taxe_2
  IF ~!PartyGoldGT(9)~ THEN GOTO ds_taxe_5
END
IF ~~ THEN BEGIN ds_taxe_2
  SAY @150
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_taxe_3
  SAY @151
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN ds_taxe_4
  SAY #50173
  IF ~~ THEN DO ~RunAwayFrom(LastTalkedToBy,50)~ EXIT
END
IF ~~ THEN BEGIN ds_taxe_5
  SAY @153
  IF ~~ THEN EXIT
END
END
