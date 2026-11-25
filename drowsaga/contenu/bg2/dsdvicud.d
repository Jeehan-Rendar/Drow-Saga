BEGIN ~DSDVICUD~
IF ~Global("DS_VICUD_B","GLOBAL",2)~ THEN BEGIN 0
  SAY @641 = @642 = @643
  IF ~~ THEN REPLY @644 DO ~SetGlobal("DS_VICUD_B","GLOBAL",3)~ GOTO 1
  IF ~~ THEN REPLY @645 DO ~SetGlobal("DS_VICUD_B","GLOBAL",3)~ GOTO 2
  IF ~~ THEN REPLY @646 DO ~SetGlobal("DS_VICUD_B","GLOBAL",3)~ GOTO 3
END
IF ~~ THEN BEGIN 1
  SAY @647 = @648 = @649
  IF ~!Global("ViconiaRomanceActive","GLOBAL",1) !Global("ViconiaRomanceActive","GLOBAL",2)~ THEN GOTO 4
  IF ~OR(2) Global("ViconiaRomanceActive","GLOBAL",1) Global("ViconiaRomanceActive","GLOBAL",2)~ THEN GOTO 5
END
IF ~~ THEN BEGIN 2
  SAY @650 = @651 = @652
  IF ~!Global("ViconiaRomanceActive","GLOBAL",1) !Global("ViconiaRomanceActive","GLOBAL",2)~ THEN GOTO 4
  IF ~OR(2) Global("ViconiaRomanceActive","GLOBAL",1) Global("ViconiaRomanceActive","GLOBAL",2)~ THEN GOTO 5
END
IF ~~ THEN BEGIN 3
  SAY @653 = @654 = @655
  IF ~!Global("ViconiaRomanceActive","GLOBAL",1) !Global("ViconiaRomanceActive","GLOBAL",2)~ THEN GOTO 4
  IF ~OR(2) Global("ViconiaRomanceActive","GLOBAL",1) Global("ViconiaRomanceActive","GLOBAL",2)~ THEN GOTO 5
END
IF ~~ THEN BEGIN 4
  SAY @656
  IF ~~ THEN EXIT
END
IF ~~ THEN BEGIN 5
  SAY @657 = @658 = @659
  IF ~~ THEN EXIT
END
