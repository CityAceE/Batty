; Предварительная подготовка к запуску

  DI
  LD SP,stack
  XOR A
  OUT ($FE),A

; -----------------
; Генерируется таблица по адресу $F200-$FFFF ($E00 байт)
; По этой таблице сдвигаются спрайты по горизонтали, кроме шарика и всех видов кареток.
  
  LD HL,table_shifts
  LD B,$01
table_gen_0:
  LD C,$00
table_gen_1:
  LD D,C
  LD E,B
  XOR A
table_gen_2:
  SRL D
  RRA
  DEC E
  JR NZ,table_gen_2
  INC H
  LD (HL),A
  DEC H
  LD (HL),D
  INC HL
  INC C
  JR NZ,table_gen_1
  INC H
  INC B
  BIT 3,B
  JR Z,table_gen_0

; -------------------

  CALL spr_shift_gen	; Генерация сдвинутых спрайтов шарика и всех видов кареток

; Инвертируется некоторая графика
  LD IX,gfx_bat
gfx_inverse_1:
  LD L,(IX+$00)
  LD H,(IX+$01)
  LD A,L
  OR H
  JR Z,L6800_6	; Прекращаем, если вместо адреса следующего спрайта нули
  INC IX
  INC IX
  LD C,(HL)
  INC HL
  LD E,(HL)
  INC HL
gfx_inverse_2:
  LD B,C
gfx_inverse_3:
  LD A,(HL)
  INC HL
  XOR (HL)
  LD (HL),A
  INC HL
  DJNZ gfx_inverse_3
  DEC E
  JR NZ,gfx_inverse_2
  JR gfx_inverse_1

L6800_6:
  LD A,$0C	; Устанавливается высота спрайта ракеты в 12 пикселей (отсекается пламя)
  LD (spr_bonus_rocket_1+1),A
  JP game_start  ; Запуск игры

; Routine at 6853
;
; Used by the routine at 6800.
; Формирование сдвинутых спрайтов для мяча и разных видов кареток
spr_shift_gen:
  LD IX,L68D7
L6800_8:
  LD L,(IX+$00)
  LD H,(IX+$01)
  LD A,H
  OR L
  RET Z
  LD C,(IX+$02)
  SRL C
  LD E,(IX+$03)
  LD D,(IX+$04)
  LD A,$01
  LD (L68A4+1),A
L6800_9:
  SRL C
  PUSH BC
  CALL C,one_spr_shift_gen
  POP BC
  LD A,C
  AND A
  JR Z,L6800_10
  LD A,(L68A4+1)
  INC A
  LD (L68A4+1),A
  JR L6800_9
L6800_10:
  LD DE,$0005
  ADD IX,DE
  JR L6800_8

; Routine at 688B
;
; Used by the routine at 6853.
; Генерация одной фазы сдвига спрайта
; HL - адрес спрайта
; DE - адрес пустого спрайта
; C - сдвиг

one_spr_shift_gen:
  PUSH HL
  LD A,(HL)
  LD (L6899+1),A	; Ширина обрабатываемого спрайта в байтах
  INC A
  LD (DE),A			; Ширина + 1 обрабатываемого спрайта в байтах
  INC HL
  INC DE
  LD A,(HL)
  LD (DE),A			; Высота обрабатываемого спрайта
  INC HL
  INC DE
L6800_12:
  EX AF,AF'

L6899:
  LD B,$00		; Начинается цикл по ширине спрайта
L6800_13:
  PUSH BC
  PUSH DE
  LD A,(HL)		; А - байт маски
  INC HL
  LD E,(HL)		; E - байт спрайта
  INC HL
  LD D,$00
  LD C,D
L68A4:
  LD B,$00
L6800_14:
  SRL E
  RR D
  SRL A
  RR C
  DJNZ L6800_14
  LD B,A
  LD A,D
  LD (L68C8+1),A
  LD A,E
  LD (L68BF+1),A
  POP DE
  LD A,(DE)
  OR B
  LD (DE),A
  INC DE
  LD A,(DE)
L68BF:
  OR $00
  LD (DE),A
  INC DE
  LD A,(DE)
  OR C
  LD (DE),A
  INC DE
  LD A,(DE)
L68C8:
  OR $00
  LD (DE),A
  DEC DE
  POP BC
  DJNZ L6800_13
  INC DE
  INC DE
  EX AF,AF'
  DEC A
  JR NZ,L6800_12
  POP HL
  RET

; Data block at 68D7
L68D7:
  DEFW spr_ball_normal			; Спрайт для сдвига
  DEFB $FF						; Ненулевой бит - фаза сдвига (7 фаз - первый бит не учитывается)
  DEFW spr_ball_normal_shift_1	; Куда помещать сдвинутые спрайты

  DEFW spr_bat_normal			; Спрайт для сдвига
  DEFB $10						; Ненулевой бит - фаза сдвига (1 фаза)
  DEFW spr_bat_normal_shift		; Куда помещать сдвинутый спрайт

  DEFW spr_bat_big				; Спрайт для сдвига
  DEFB $10						; Ненулевой бит - фаза сдвига (1 фаза)
  DEFW spr_bat_big_shift		; Куда помещать сдвинутый спрайт

  DEFW spr_bat_gun				; Спрайт для сдвига
  DEFB $10						; Ненулевой бит - фаза сдвига (1 фаза)
  DEFW spr_bat_gun_shift		; Куда помещать сдвинутый спрайт

  DEFW $0000 ; Маркер конца
