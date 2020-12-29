; Графика: элементы обрамления экрана

; Data block at 6B17
; Левый боковой элемент в виде двух концов ракеток (дверь?)
; В игре нигде не используется
spr_bord_unused:
  DEFB $01,$20,$9F,$00,$00,$00,$00,$CF
  DEFB $6E,$3C,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$3C,$6E,$CF,$00,$00,$00
  DEFB $00,$9F,$01,$04,$45,$47,$47,$45

; Следующие два спрайта должны идти строго друг за другом
; Data block at 6B3F
; Левая боковина в виде ракетки
spr_bord_left_bold:
  DEFB $01,$20,$3C,$6E,$CF,$9F,$9F,$9F
  DEFB $9F,$60,$9F,$9F,$9F,$9F,$9F,$9F
  DEFB $9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F
  DEFB $9F,$9F,$60,$9F,$9F,$9F,$9F,$CF
  DEFB $6E,$3C,$01,$04,$45,$05,$05,$45
; Data block at 6B67
; Правая боковина в виде ракетки
  DEFB $01,$20,$3C,$76,$F3,$F9,$F9,$F9
  DEFB $F9,$06,$F9,$F9,$F9,$F9,$F9,$F9
  DEFB $F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9
  DEFB $F9,$F9,$06,$F9,$F9,$F9,$F9,$F3
  DEFB $76,$3C,$01,$04,$45,$05,$05,$45

; Следующие два спрайта должны идти строго друг за другом
; Data block at 6B8F
; Левая боковина в виде трубы
spr_bord_left_thin:
  DEFB $01,$18,$00,$3C,$3C,$3C,$3C,$3C
  DEFB $3C,$3C,$00,$5E,$5E,$5E,$5E,$5E
  DEFB $5E,$00,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $3C,$00,$01,$03,$07,$47,$07
; Data block at 6BAE
; Правая боковина в виде трубы
  DEFB $01,$18,$00,$3C,$3C,$3C,$3C,$3C
  DEFB $3C,$3C,$00,$7A,$7A,$7A,$7A,$7A
  DEFB $7A,$00,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $3C,$00,$01,$03,$07,$47,$07

; Data block at 6BCD
; Горизонталь, левый крайний элемент
spr_bord_horiz_left_edge:
  DEFB $04,$08,$9E,$FF,$FF,$6C,$9D,$FF
  DEFB $FF,$6E,$9B,$FF,$FF,$6F,$97,$FF
  DEFB $FF,$6F,$AF,$FF,$FF,$69,$D0,$00
  DEFB $00,$93,$A0,$00,$00,$96,$7F,$FF
  DEFB $FF,$6C,$04,$01,$05,$05,$05,$45

; Data block at 6BF5
; Горизонталь, левая сторона в виде трубы
spr_bord_horiz_left_thin:
  DEFB $04,$08,$00,$00,$00,$3E,$00,$7E
  DEFB $00,$7E,$7F,$7E,$FE,$FE,$7F,$7E
  DEFB $FE,$FE,$7F,$7E,$FE,$9E,$7F,$00
  DEFB $FE,$C1,$00,$7E,$00,$61,$00,$00
  DEFB $00,$3E,$04,$01,$07,$47,$07,$45

; Data block at 6C1D
; Горизонталь, левая сторона в виде ракетки
spr_bord_horiz_left_bold:
  DEFB $04,$08,$FF,$FF,$FF,$7C,$FF,$FF
  DEFB $FF,$7E,$FF,$FF,$FF,$7F,$FF,$FF
  DEFB $FF,$7F,$FF,$FF,$FF,$79,$00,$00
  DEFB $00,$83,$00,$00,$00,$86,$FF,$FF
  DEFB $FF,$7C,$04,$01,$05,$05,$05,$45

; Data block at 6C45
; Горизонталь, правая сторона в виде трубы
spr_bord_horiz_right_thin:
  DEFB $04,$08,$7C,$00,$00,$00,$7E,$00
  DEFB $7E,$00,$7F,$7F,$7E,$FE,$7F,$7F
  DEFB $7E,$FE,$79,$7F,$7E,$FE,$83,$7F
  DEFB $00,$FE,$86,$00,$7E,$00,$7C,$00
  DEFB $00,$00,$04,$01,$45,$07,$47,$07

; Data block at 6C6D
; Горизонталь, правая сторона в виде ракетки
spr_bord_horiz_right_bold:
  DEFB $04,$08,$3E,$FF,$FF,$FF,$7E,$FF
  DEFB $FF,$FF,$FE,$FF,$FF,$FF,$FE,$FF
  DEFB $FF,$FF,$9E,$FF,$FF,$FF,$C1,$00
  DEFB $00,$00,$61,$00,$00,$00,$3E,$FF
  DEFB $FF,$FF,$04,$01,$45,$05,$05,$05

; Data block at 6C95:
; Горизонталь, правый крайний элемент
spr_bord_horiz_right_edge:
  DEFB $04,$08,$36,$FF,$FF,$79,$76,$FF
  DEFB $FF,$B9,$F6,$FF,$FF,$D9,$F6,$FF
  DEFB $FF,$E9,$96,$FF,$FF,$F5,$C9,$00
  DEFB $00,$0B,$69,$00,$00,$05,$36,$FF
  DEFB $FF,$FE,$04,$01,$45,$05,$05,$05
