; Формат графики Маска-Спрайт-Маска-Спрайт... По знакоместам!
; Первые две цифры - заголовок:
; 1 - ширина в байтах (без учёта маски)
; 2 - высота в пикселях

; Спрайт: надпись 1UP
; Data block at 68ED
spr_1up:
  DEFB $03,$08,$3C,$00,$FE,$00,$FC,$00
  DEFB $7C,$18,$FE,$6C,$FF,$7C,$7C,$38
  DEFB $FE,$6C,$FF,$66,$7C,$18,$FE,$6C
  DEFB $FF,$66,$3C,$18,$FE,$6C,$FF,$7C
  DEFB $7E,$18,$FE,$7C,$FE,$60,$7E,$3C
  DEFB $FE,$38,$F0,$60,$7E,$00,$7C,$00
  DEFB $F0,$00

; Спрайт: надпись 2UP
; Data block at 691F
spr_2up:
  DEFB $03,$08,$7C,$00,$FE,$00,$FE,$00
  DEFB $FE,$38,$FE,$6C,$FF,$7C,$FE,$7C
  DEFB $FE,$6C,$FF,$66,$FE,$6C,$FE,$6C
  DEFB $FF,$66,$FE,$18,$FE,$6C,$FF,$7C
  DEFB $FE,$30,$FE,$7C,$FE,$60,$FE,$7C
  DEFB $FE,$38,$F0,$60,$FE,$00,$7C,$00
  DEFB $F0,$00

; Спрайт: надпись HI
; Data block at 6951
spr_hi:
  DEFB $02,$08,$7F,$00,$BC,$00,$7F,$33
  DEFB $BC,$18,$7F,$33,$BC,$18,$7F,$3F
  DEFB $BC,$18,$7F,$3F,$BC,$18,$7F,$33
  DEFB $BC,$18,$7F,$33,$BC,$18,$7F,$00
  DEFB $BC,$00

; Спрайт: цифры для отображения очков
; Data block at 6973
spr_score_digits:
  DEFB $0A,$08,$7C,$00,$FE,$38,$FE,$6C
  DEFB $FE,$6C,$FE,$6C,$FE,$6C,$FE,$38
  DEFB $7C,$00,$3C,$00,$7C,$18,$7C,$38
  DEFB $7C,$18,$3C,$18,$7E,$18,$7E,$3C
  DEFB $7E,$00,$7C,$00,$FE,$38,$FE,$7C
  DEFB $FE,$6C,$FE,$18,$FE,$30,$FE,$7C
  DEFB $FE,$00,$7C,$00,$FE,$38,$FE,$6C
  DEFB $FE,$18,$FE,$18,$FE,$6C,$FE,$38
  DEFB $7C,$00,$3C,$00,$7C,$18,$7C,$38
  DEFB $FC,$28,$FE,$68,$FE,$7C,$FE,$18
  DEFB $3C,$00,$FE,$00,$FE,$7C,$FE,$60
  DEFB $FE,$78,$FE,$0C,$FE,$6C,$FE,$38
  DEFB $7C,$00,$3C,$00,$7C,$18,$FC,$30
  DEFB $FE,$78,$FE,$6C,$FE,$6C,$FE,$38
  DEFB $7C,$00,$FE,$00,$FE,$7C,$FE,$7C
  DEFB $FE,$18,$7C,$38,$7C,$30,$78,$30
  DEFB $78,$00,$7C,$00,$FE,$38,$FE,$6C
  DEFB $FE,$38,$FE,$6C,$FE,$6C,$FE,$38
  DEFB $7C,$00,$7C,$00,$FE,$38,$FE,$6C
  DEFB $FE,$6C,$FE,$3C,$7E,$18,$7C,$30
  DEFB $78,$00
