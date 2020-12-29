; Routine at 910C
;
; Used by the routine at LBC10.
; Ввод имени нового рекордсмена, обновление таблицы рекордов и её вывод на экран
;input_new_record_name:
  DI
  LD IX,txt_high_score_table+227 ; Текст последней строчки таблицы
  LD HL,current_score_1up+2
  LD DE,score_six_digits
  LD B,$03
L910C_0:
  LD A,(HL)
  RRA
  RRA
  RRA
  RRA
  AND $0F
  LD (DE),A
  INC DE
  LD A,(HL)
  AND $0F
  LD (DE),A
  INC DE
  DEC HL
  DJNZ L910C_0
  LD IY,score_six_digits
  LD D,$0B
L910C_1:
  LD B,$06
  PUSH IY
  PUSH IX
L910C_2:
  LD A,(IX+$00)
  CP (IY+$00)
  JR C,L910C_4
  JR NZ,L910C_3
  INC IX
  INC IY
  DJNZ L910C_2
L910C_3:
  POP IX
  POP IY
  LD A,D
  CP $0B
  RET Z
  JR L910C_5
L910C_4:
  DEC D
  POP IX
  POP IY
  LD BC,$FFEE
  ADD IX,BC
  LD A,D
  DEC A
  JR NZ,L910C_1
L910C_5:
  LD A,$0A
  SUB D
  JR Z,L910C_7
  LD DE,txt_high_scores-1
  LD HL,txt_high_score_table+222 ; Последняя строка таблицы рекордов
L910C_6:
  LD BC,$000E
  LDDR
  DEC HL
  DEC HL
  DEC HL
  DEC HL
  DEC DE
  DEC DE
  DEC DE
  DEC DE
  DEC A
  JR NZ,L910C_6
L910C_7:
  LD DE,$0012
  ADD IX,DE
  PUSH IX
  POP DE
  LD HL,score_six_digits
  LD BC,$0006
  LDIR
  LD C,$26
  LD (IX+$09),$0A
  LD (IX+$0A),C
  LD (IX+$0B),C
  LD (IX+$0C),C
  LD (IX+$0D),C
  CALL clear_screen_attrib
  CALL clear_screen_pix
  CALL disp_high_score_table_screen
  LD A,(player_number)
  INC A
  LD (txt_player_0_enter_your_name+13),A
  LD DE,txt_player_0_enter_your_name
  CALL print_line
  CALL print_line
  PUSH IX
  POP HL
  DEC HL
  DEC HL
  DEC HL
  DEC HL
  LD (text_line_addr),HL
  LD B,$05
L910C_8:
  LD C,$0A
  PUSH BC
L910C_9:
  CALL get_control_state_1up
  LD A,(ctrl_btns_pressed)
  AND $13
  JR Z,L910C_9
  BIT 4,A
  JR NZ,L910C_12
  CP $03
  JR Z,L910C_9
  POP BC
  RRA
  JR NC,L910C_10
  INC C
  LD A,C
  CP $28
  JR NZ,L910C_11
  LD C,$00
  JR L910C_11
L910C_10:
  DEC C
  BIT 7,C
  JR Z,L910C_11
  LD C,$27
L910C_11:
  LD (IX+$09),C
  PUSH BC
  LD DE,(text_line_addr)
  CALL print_line
  CALL play_sound_choose_letter
  LD D,$20
  CALL pause_short
  JR L910C_9
L910C_12:
  CALL play_sound_confirm_letter
  POP BC
  DEC B
  JR Z,L910C_14
  INC IX
  LD (IX+$09),$0A
  PUSH BC
  LD DE,(text_line_addr)
  CALL print_line
L910C_13:
  CALL get_control_state_1up
  LD A,(ctrl_btns_pressed)
  AND $10
  JR NZ,L910C_13
  POP BC
  JR L910C_8
L910C_14:
  CALL disp_high_score_table_screen
  LD B,$0A
  JP pause_long

; Data block at 9229
; Сюда помещается адрес следующей строки текста для печати
text_line_addr:
  DEFW $0000
win_full_screen_purple_ink:
  DEFB $20,$18,$43
full_screen_red:
  DEFB $20,$18,$42

; Routine at 9231
;
; Used by the routines at disp_high_score_table_screen and L93F8.
; Рисует рамку вокруг экрана
draw_frame:
  LD HL,$0000
  LD (counter_misc),HL
  CALL clear_screen_attrib
  CALL clear_screen_pix
; Рисуются боковины
  LD HL,$57E0	; Адрес в экранной области
  LD DE,$57FF	; Адрес в экранной области
  LD B,$C0
draw_frame_0:
  LD (HL),$C0
  LD A,$03
  LD (DE),A
  CALL dec_scr_line
  EX DE,HL
  CALL dec_scr_line
  EX DE,HL
  DJNZ draw_frame_0
; Рисуется верх и низ
  LD HL,$56E0	; Адрес в экранной области
  LD DE,$4000	; Адрес в экранной области
  LD B,$20
  LD A,$FF
draw_frame_1:
  LD (HL),A
  INC H
  LD (HL),A
  DEC H
  LD (DE),A
  INC D
  LD (DE),A
  DEC D
  INC L
  INC E
  DJNZ draw_frame_1
  RET

; Routine at 926B
;
; Used by the routines at input_new_record_name and L927F.
disp_high_score_table_screen:
  CALL draw_frame
  LD HL,$BF00	; Координаты окна (весь экран нижняя строка)
  LD DE,full_screen_red
  CALL fill_win_attrib
  LD DE,txt_high_score_table
  LD B,$16
  JP print_message

; Routine at 927F
;
; Used by the routine at disp_main_menu_and_wait_keys.
disp_hs_table_and_wait_keys:
  CALL disp_high_score_table_screen
L927F_0:
  LD A,$EF
  CALL in_a_fe	; IN A,($EFFE) 67890
  RRA
  RET C			; Выход из общей подпрограммы, если нажат 0
  XOR A
  CALL in_a_fe	; IN A,($00FE)
  JP NZ,disp_main_menu_and_wait_keys	; Переход на отображение главного меню, если нажата любая клавиша

  LD A,$80		; Цикл задержки
L927F_1:		; Цикл задержки
  DEC A			; Цикл задержки
  JR NZ,L927F_1	; Цикл задержки

  LD HL,(counter_misc)
  INC HL
  LD (counter_misc),HL
  BIT 6,H
  JP NZ,disp_main_menu_and_wait_keys	; Переход на отображение главного меню, если счётчик достиг нужного значения
  JR L927F_0
