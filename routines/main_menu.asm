; Routine at 93F8
;
; Used by the routines at disp_hs_table_and_wait_keys and LB9E8.
;disp_main_menu_and_wait_keys:
  LD HL,$0000
  LD (back_counters),HL
  CALL draw_frame
  LD HL,$BF00		; Координаты окна (весь экран нижняя строка)
  LD DE,win_full_screen_purple_ink
  CALL fill_win_attrib
  LD HL,$B708		; Координаты окна
  LD DE,win_1e_16_white_ink
  CALL fill_win_attrib

  LD HL,$4718		; Адрес на экране
  LD DE,spr_press_a
  CALL print_sprite	; Press A

  LD HL,$47C8		; Адрес на экране
  LD DE,spr_press_b
  CALL print_sprite	; Press B

  LD HL,current_score_1up+2
  LD DE,txt_score_1up+4
  CALL score_to_text
  LD HL,current_score_2up+2
  LD DE,txt_score_2up+4
  CALL score_to_text

  LD DE,txt_main_menu
  LD B,$0F				; Количество строк в сообщении
  CALL print_message

  LD HL,(coord_ctrl_1up)
  LD DE,spr_pointer_1
  CALL print_sprite
  LD HL,(coord_ctrl_2up)
  LD DE,spr_pointer_2
  CALL print_sprite

L93F8_0:
  LD HL,(counter_misc)
  INC HL
  LD (counter_misc),HL
  BIT 6,H
  JP NZ,disp_hs_table_and_wait_keys		; Переход на отображение таблицы рекордов
  CALL random_generate
  LD DE,(game_mode)
  LD A,$F7
  CALL in_a_fe	; IN A,($F7FE) 54321 (12345)
  BIT 0,A		; Нажата ли клавиша 1?
  JR Z,L93F8_1
  LD A,E
  AND A
  JR Z,L93F8_4
  LD E,$00
  LD HL,txt_1_player
  JR L93F8_3
L93F8_1:
  BIT 2,A		; Нажата ли клавиша 3?
  JR Z,L93F8_2
  LD A,E
  CP $02
  JR Z,L93F8_4
  LD E,$02
  LD HL,txt_double_play
  JR L93F8_3
L93F8_2:
  BIT 1,A		; Нажата ли клавиша 2?
  JR Z,L93F8_4
  DEC E
  JR Z,L93F8_4
  LD E,$01
  LD HL,txt_2_players
L93F8_3:
  LD A,E
  LD (game_mode),A
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,$2F
  LD E,A
  LD D,$00
  LD (current_game_mode_line_prop),DE
  PUSH HL
  LD DE,(pointer_game_mode_text)
  CALL print_line
  POP HL
  LD (pointer_game_mode_text),HL
L93F8_4:
  LD A,(back_counters)
  AND A
  JR Z,L93F8_5
  DEC A
  LD (back_counters),A
  JR L93F8_7

;----------------------------
L93F8_5:
  LD A,$FD
  CALL in_a_fe	; IN A,($FDFE) GFDSA (ASDFG)
  RRA
  JR NC,L93F8_7
; Нажата кнопка A
  LD A,(ctrl_type_1up)	
  INC A
  AND $03
  LD (ctrl_type_1up),A
  LD HL,(coord_ctrl_1up)
  LD DE,spr_pointer_empty
  CALL print_sprite
  LD A,(coord_ctrl_1up+1)
  ADD A,$10
  CP $A0
  JR C,L93F8_6
  LD A,$6C
L93F8_6:
  LD (coord_ctrl_1up+1),A
  LD HL,(coord_ctrl_1up)
  LD DE,spr_pointer_1
  CALL print_sprite
  LD A,$FF
  LD (back_counters),A
  CALL play_sound_choose_ctrl
L93F8_7:
  LD A,(back_counters+1)
  AND A
  JR Z,L93F8_8
  DEC A
  LD (back_counters+1),A
  JR L93F8_10
;--------------------------

;--------------------------
L93F8_8:
  LD A,$7F
  CALL in_a_fe	; IN A,($7FFE)
  AND $10
  JR Z,L93F8_10
; Нажата кнопка B
  LD A,(ctrl_type_2up)
  INC A
  AND $03
  LD (ctrl_type_2up),A
  LD HL,(coord_ctrl_2up)
  LD DE,spr_pointer_empty
  CALL print_sprite
  LD A,(coord_ctrl_2up+1)
  ADD A,$10
  CP $A0
  JR C,L93F8_9
  LD A,$6C
L93F8_9:
  LD (coord_ctrl_2up+1),A
  LD HL,(coord_ctrl_2up)
  LD DE,spr_pointer_2
  CALL print_sprite
  LD A,$FF
  LD (back_counters+1),A
  CALL play_sound_choose_ctrl
L93F8_10:
  LD DE,current_game_mode_line_prop
  CALL fill_color_current_game_mode
  LD A,$EF
  CALL in_a_fe	; IN A,($EFFE) 67890
  AND $01
  RET NZ		; Выход из общей процедуры (запуск игры), если нажат 0
  JP L93F8_0
