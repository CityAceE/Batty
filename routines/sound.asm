;=====================================================================
; Процедуры для вывода звуков

; Routine at C064
;
; Used by the routines at L965D, L9F64, LA27E, LA65B, LA67B, LA860, LAB13 and
; LAFFC.
; Ищет первый свободный слот для звука в очереди звуков
; На выходе в IX - адрес свободного слота
get_free_sound_slot:
  LD IX,sounds_queue
  LD B,$04
  LD DE,$0007
LC064_0:
  LD A,(IX+$00)
  AND A
  RET Z
  ADD IX,DE
  DJNZ LC064_0
  RET


; Routine at C077
;
; Used by the routines at LAF81, LBAED, LBB97, LBBFB and LBC10.
; Проигрывание очереди звуков с использованием IM1 для отсчёта кадров
; На выходе Z, если уложились менее, чем во сколько-то прерываний
play_sounds_queue:
  LD IY,(iy_storage)
  LD A,(frames)
  LD (frames_copy),A
  EI
  IM 1
  LD A,(scr_score_need_upd)
  AND A
  CALL NZ,scr_score_update
  LD IX,sounds_queue
  LD B,$05
play_sounds_queue_0:
  PUSH BC
  LD A,(IX+$00)
  AND A
  CALL NZ,play_selected_sound
  LD BC,$0007
  ADD IX,BC
  POP BC
  DJNZ play_sounds_queue_0
  LD A,(frames)
  LD B,A
  LD A,(frames_copy)
  CP B
  DI
  RET

; Routine at C0AB
;
; Used by the routine at play_sounds_queue.
; Проигрывает звук, номер которого задан в А
play_selected_sound:
  LD HL,play_sounds_list-2
  ADD A,A
  LD E,A
  LD D,$00
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  JP (HL)

; Data block at C0B8
; Очередь проигрываемых звуков по IM1: 5 строк по 7 элементов
sounds_queue:
  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00

; Таблица адресов подпрограмм проигрывания различных звуков
play_sounds_list:
  DEFW play_sound_normall_brik	; 01 - Звук удара об обычный кирпич
  DEFW play_sound_metal_brik	; 02 -
  DEFW play_sound_bat_beat		; 03 - Звук удара шара о каретку
  DEFW play_sound_ball_start	; 04 - Звук выстрела шара с картеки
  DEFW play_sound_05			; 05 - 
  DEFW play_sound_06			; 06 - 
  DEFW play_sound_live_add		; 07 - Звук добавление жизни
  DEFW play_sound_08			; 08 - 
  DEFW play_sound_bat_resize_1	; 09 - Один из составных звуков изменения размера каретки
  DEFW play_sound_triple_ball	; 0A - Звук размножения шариков
  DEFW play_sound_shot			; 0B - Звук выстрела
  DEFW play_sound_bat_resize_2	; 0C - Один из составных звуков изменения размера каретки

  ; DEFW play_sound_unused		; 0D - Неиспользуемый звук
  ; DEFW stop_game				; 0E - DI:HALT

; stop_game:
	; DI
	; HALT

sound_normall_brik 	EQU $01
sound_bat_beat 		EQU $03
sound_ball_start 	EQU $04
sound_live_add 		EQU $07
sound_bat_resize_1 	EQU $09
sound_triple_ball 	EQU $0A
sound_shot 			EQU $0B
sound_bat_resize_2 	EQU $0C

; Routine at C0F3
play_sound_normall_brik:
  LD DE,$0844
  CALL sound_beep_cont_d
  DEC (IX+$01)
  LD (IX+$00),$00
  RET

; Routine at C101
play_sound_metal_brik:
  LD D,$18
  LD E,$30
  CALL sound_beep_cont_d
  XOR A
  LD (frames_copy),A
  LD A,$80
  LD (frames),A
  LD (IX+$00),$00
  RET

; Routine at C116
play_sound_ball_start:
  LD C,$09
  LD E,$14
  CALL play_sound_LC122
  LD (IX+$00),$00
  RET

; Routine at C122
;
; Used by the routines at play_sound_ball_start, play_sound_confirm_letter and play_sound_shot.
play_sound_LC122:
  LD A,C
  XOR E
  ADD A,A
  LD B,A
  AND $0F
  LD D,A
  LD A,B
  AND $0C
  ADD A,$08
  LD B,A
  CALL sound_beep2
  DEC C
  JR NZ,play_sound_LC122
  RET

; Routine at C136
;
; Used by the routines at play_sound_LC122, play_sound_choose_ctrl and play_sound_choose_letter.
sound_beep2:
  LD A,$10
  OUT ($FE),A
sound_beep2_0:
  DJNZ sound_beep2_0
  XOR A
  OUT ($FE),A
  LD B,D
sound_beep2_1:
  DJNZ sound_beep2_1
  RET

; Routine at C143
;
; Used by the routine at disp_main_menu_and_wait_keys.
play_sound_choose_ctrl:
  LD E,$40
  LD D,$80
; This entry point is used by the routine at play_sound_magnet.
play_sound_choose_ctrl_0:
  LD B,C
  CALL sound_beep2
  INC D
  INC C
  DEC E
  JR NZ,play_sound_choose_ctrl_0
  RET

; Routine at C151
;
; Used by the routine at print_one_magnet.
play_sound_magnet:
  LD E,$18
  LD C,$18
  LD D,$40
  JR play_sound_choose_ctrl_0

; Routine at C159
;
; Used by the routine at input_new_record_name.
play_sound_choose_letter:
  LD E,$E0
  LD C,E
  LD D,$60
play_sound_choose_letter_0:
  LD B,C
  CALL sound_beep2
  DEC D
  INC C
  DEC E
  JR NZ,play_sound_choose_letter_0
  RET

; Routine at C168
;
; Used by the routine at input_new_record_name.
play_sound_confirm_letter:
  LD C,$FF
  LD E,$3F
  JP play_sound_LC122

; Routine at C16F
play_sound_bat_beat:
  LD DE,$0466
  CALL sound_beep_cont_d
  LD (IX+$00),$00
  RET

; Routine at C17A
play_sound_05:
  LD E,(IX+$02)
  LD D,$01
  CALL sound_beep_cont_d
  INC (IX+$02)
  INC (IX+$02)
  INC (IX+$02)
  RET

;-----------------------------
; НЕИСПОЛЬЗУЕМЫЙ В ИГРЕ КОД!
; Интересный звук, которого нет в игре!
; Routine at C18C
play_sound_unused:
  LD A,$18
  LD L,$01
play_sound_LC190:
  EX AF,AF'
  LD DE,$01FF
play_sound_LC190_0:
  PUSH DE
  CALL sound_beep_cont_d
  POP DE
  LD A,E
  SUB L
  LD E,A
  JR NC,play_sound_LC190_0
  LD A,$04
  ADD A,L
  LD L,A
  EX AF,AF'
  DEC A
  JR NZ,play_sound_LC190
  DI
  RET
;-----------------------------

; Routine at C1A8
play_sound_06:
  LD A,(random_number)
  AND $3F
  ADD A,(IX+$01)
  LD E,A
  LD D,$01
  CALL sound_beep_cont_d
  LD A,(IX+$01)
  ADD A,$08
  LD (IX+$01),A
  CP $A1
  JR Z,play_sound_06_0
  CP $60
  RET NZ
  LD (IX+$01),$21
  RET
play_sound_06_0:
  LD (IX+$00),$00
  RET

; Routine at C1CF
play_sound_live_add:
  LD A,(IX+$01)
  AND $03
  JR NZ,play_sound_07_0
  LD A,(IX+$01)
  ADD A,$14
  LD E,A
  LD D,$03
  CALL sound_beep_cont_d
play_sound_07_0:
  DEC (IX+$01)
  DEC (IX+$01)
  RET NZ
  LD (IX+$00),$00
  RET

; Routine at C1ED
play_sound_08:
  LD A,(IX+$01)
  RRA
  RRA
  AND $3F
  ADD A,$20
  LD E,A
  LD D,$02
  CALL sound_beep_cont_de
  INC (IX+$01)
  RET

; Routine at C200
play_sound_bat_resize_1:
  LD A,(bonus_flag)
  AND A
  RET NZ
  LD E,(IX+$01)
  LD D,$01
  CALL sound_beep_cont_d
  LD A,(IX+$01)
  SUB $0B
  LD (IX+$01),A
  CP $10
  RET NC
  LD (IX+$00),$00
  RET

; Routine at C21D
play_sound_triple_ball:
  LD E,(IX+$01)
  LD D,$01
  CALL sound_beep_cont_d
  LD A,(IX+$01)
  ADD A,$0B
  LD (IX+$01),A
  CP $C1
  RET C
  LD (IX+$00),$00
  RET

; Routine at C235
play_sound_shot:
  LD C,$04
  LD E,$0F
  CALL play_sound_LC122
  LD (IX+$00),$00
  RET

; Routine at C241
play_sound_bat_resize_2:
  LD E,$30
  LD D,$0A
  CALL sound_beep_cont_de
  LD (IX+$00),$00
  RET

; Routine at C24D
;
; Used by the routines at sound_beep_cont_d and sound_beep_cont_de.
sound_beep:
  LD B,E
  EI
  LD A,$10
  OUT ($FE),A
sound_beep_0:
  DJNZ sound_beep_0
  LD B,E
  XOR A
  OUT ($FE),A
sound_beep_1:
  DJNZ sound_beep_1
  RET

; Routine at C25C
;
; Used by the routines at L9F64, play_sound_normall_brik, play_sound_metal_brik, play_sound_bat_beat, play_sound_05, play_sound_06, play_sound_live_add,
; play_sound_bat_resize_1 and play_sound_triple_ball.
sound_beep_cont_d:
  CALL sound_beep
  DEC D
  JR NZ,sound_beep_cont_d
  RET

; Routine at C263
;
; Used by the routines at play_sound_08 and play_sound_bat_resize_2.
sound_beep_cont_de:
  CALL sound_beep
  LD A,$F8
  ADD A,E
  LD E,A
  DEC D
  JR NZ,sound_beep_cont_de
  RET
