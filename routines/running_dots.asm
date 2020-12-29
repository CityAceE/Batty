; Data block at B8D6
; Кадр рисования точек на каретке для второго игрока
running_dot_frame_2up:
  DEFB $0E

; Routine at B8D7
;
; Used by the routine at LBAED.
; Обмен содержимым ячеек running_dot_frame_1up и running_dot_frame_2up
running_dot_frame_swap:
  LD A,(running_dot_frame_1up)
  LD B,A
  LD A,(running_dot_frame_2up)
  LD (running_dot_frame_1up),A
  LD A,B
  LD (running_dot_frame_2up),A
  RET

; Routine at B8E6
;
; Used by the routine at LBAED.
; Рисование двух бегающих точек на каретке
running_dot:
  LD DE,scr_buff+$1660 ; $F060 - адрес строки в буфере, где бегают точки по каретке
  LD A,(running_dot_frame_1up)
  AND $7F
  LD B,A
  LD A,(IX+$0C)
  SUB B
  CP $09
  JR NC,LB8E6_0
  LD A,(IX+$0C)
  SUB $0B
  LD B,A		; В В констаната для расчёта обеих точек
  LD A,(running_dot_frame_1up)
  AND $80
  OR B
  LD (running_dot_frame_1up),A
LB8E6_0:
  LD A,(IX+$02)	; Координата X для печати
  ADD A,B
  LD C,A
  RRA
  RRA
  RRA
  AND $1F
  ADD A,E	; Добавляем к А младший байт адреса в экранном буфере
  LD E,A
  LD A,C	; Положение точки внутри каретки
  AND $07
  LD HL,running_dot_mask
  CALL hl_add_a
  LD A,(DE)
  AND (HL)
  LD (DE),A		; Запись первой точки

  LD A,(IX+$02)	; Координата X для печати
  LD E,A
  LD A,(IX+$0C)
  ADD A,E
  SUB B
  DEC A
  LD C,A
  RRA
  RRA
  RRA
  AND $1F
  ADD A,$60	; Эта константа вычисляется из адреса буфера.
  LD E,A
  LD A,C
  AND $07
  LD HL,running_dot_mask
  CALL hl_add_a
  LD A,(DE)
  AND (HL)
  LD (DE),A		; Запись второй точки
  
  LD A,(running_dot_frame_1up)
  BIT 7,A
  RES 7,A
  JR Z,LB8E6_1
  DEC A
  CP $09
  JR Z,LB8E6_2
  OR $80
  LD (running_dot_frame_1up),A
  RET
LB8E6_1:
  INC A
  LD B,A
  LD A,(IX+$0C)
  SUB B
  CP $0A
  JR NZ,LB8E6_3
LB8E6_2:
  LD A,(running_dot_frame_1up)
  XOR $80
  LD (running_dot_frame_1up),A
  RET
LB8E6_3:
  LD A,B
  LD (running_dot_frame_1up),A
  RET

; Data block at B969
; Бегающая по каретке точка
running_dot_mask:
  DEFB %01111111	; $7F
  DEFB %10111111	; $BF
  DEFB %11011111	; $DF
  DEFB %11101111	; $EF
  DEFB %11110111	; $F7
  DEFB %11111011	; $FB
  DEFB %11111101	; $FD
  DEFB %11111110	; $FE
; Кадр рисования точек на каретке
running_dot_frame_1up:
  DEFB $0E
