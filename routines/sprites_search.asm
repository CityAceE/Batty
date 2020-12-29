; Routine at 7767
;
; Used by the routines at print_spr_with_mask_buff and calc_write_spr_addr.
; Поиск нужного спрайта по координатам в IX
; IX+0 - номер комплекта спрайтов
; IX+1 - номер спрайта в комплекте
; На выходе в DE адрес спрайта

;sprite_search:
  LD HL,gfx_pack-$02
  LD E,(IX+$00)
  SLA E
  LD D,$00
  ADD HL,DE
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD E,(IX+$01)
  SLA E
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  RET

; Таблица указателей на наборы спрайтов
; Data block at 7780
gfx_pack:
  DEFW gfx_bat				; $01 
  DEFW gfx_ball				; $02
  DEFW gfx_screen_elements	; $03
  DEFW gfx_bonuses			; $04
  DEFW gfx_bullet			; $05
  DEFW anim_rocket			; $06
  DEFW anim_spark			; $07
  DEFW anim_ufo				; $08
  DEFW anim_bird			; $09
  DEFW anim_alien_blast		; $0A
  DEFW gfx_last_sprite		; $0B

; Адреса спрайтов
; Data block at 7796
gfx_bat:
  DEFW spr_bat_normal		; $00
  DEFW spr_bat_normal_shift ; $01
  DEFW spr_bat_left_part	; $02
  DEFW spr_bat_right_part	; $03
  DEFW spr_bat_big			; $04
  DEFW spr_bat_big_shift	; $05
  DEFW spr_bat_gun_1		; $06
  DEFW spr_bat_gun_2		; $07
  DEFW spr_bat_gun_3		; $08
  DEFW spr_bat_gun_4		; $09
  DEFW spr_bat_gun			; $0A
  DEFW spr_bat_gun_shift	; $0B
  DEFW spr_bat_gun_4		; $0C
  DEFW spr_bat_gun_3		; $0D
  DEFW spr_bat_gun_2		; $0E
  DEFW spr_bat_gun_1		; $0F
  DEFW spr_bat_gun_1		; $10
  DEFW spr_bat_gun_2		; $11
  DEFW spr_bat_gun_3		; $12
  DEFW spr_bat_gun_4		; $13

; Data block at 77BE
gfx_ball:
  DEFW spr_ball_normal
  DEFW spr_ball_normal_shift_1
  DEFW spr_ball_normal_shift_2
  DEFW spr_ball_normal_shift_3
  DEFW spr_ball_normal_shift_4
  DEFW spr_ball_normal_shift_5
  DEFW spr_ball_normal_shift_6
  DEFW spr_ball_normal_shift_7
  DEFW spr_big_ball

gfx_bonuses:
  DEFW spr_bonus_size			;00
  DEFW spr_bonus_gun			;01
  DEFW spr_bonus_triple_ball	;02
  DEFW spr_bonus_hand			;03
  DEFW spr_bonus_slow			;04
  DEFW spr_bonus_extra_life		;05
  DEFW spr_bonus_rocket_1		;06
  DEFW spr_bonus_smash			;07
  DEFW spr_bonus_5000_points	;08
  DEFW spr_bonus_kill_aliens	;09
  DEFW spr_bomb					;0A

; Data block at 77E6
gfx_bullet:
  DEFW spr_bullet_1
  DEFW spr_bullet_2
  DEFW spr_bullet_blast_1
  DEFW spr_bullet_blast_2
  DEFW spr_bullet_blast_3
  DEFW spr_bullet_blast_4

anim_rocket:
  DEFW spr_bonus_rocket_1
  DEFW spr_bonus_rocket_2
  DEFW spr_bonus_rocket_1

; Data block at 77F8
anim_spark:
  DEFW spr_spark_1
  DEFW spr_spark_2
  DEFW spr_spark_3
  DEFW spr_spark_4
  DEFW spr_spark_5

  DEFW spr_ufo_1
  DEFW spr_ufo_2
  DEFW spr_ufo_3
  DEFW spr_ufo_4
  DEFW spr_ufo_5
  DEFW spr_ufo_6

; Анимация птицы
anim_bird:
  DEFW spr_bird_1
  DEFW spr_bird_2
  DEFW spr_bird_3
  DEFW spr_bird_4
  DEFW spr_bird_3
  DEFW spr_bird_2
  DEFW spr_bird_1
  DEFW spr_bird_5
  DEFW spr_bird_1
  DEFW spr_bird_2
  DEFW spr_bird_3

  DEFW spr_alien_blast_1
  DEFW spr_alien_blast_2
  DEFW spr_alien_blast_3
  DEFW spr_alien_blast_4
  DEFW spr_alien_blast_5

gfx_screen_elements:
  DEFW spr_lives_indicator
  DEFW spr_1up
  DEFW spr_2up
  DEFW spr_hi
  DEFW spr_score_digits
  DEFW spr_separator
  DEFW spr_magnet_circle_on
  DEFW spr_magnet_circle_off

; Data block at 783E
gfx_last_sprite:
  DEFW spr_400_points
  DEFW $0000 ; Маркер конца таблицы спрайтов

; Анимация взрыва врагов
anim_alien_blast:
  DEFW spr_alien_blast_1
  DEFW spr_alien_blast_2
  DEFW spr_alien_blast_3
  DEFW spr_alien_blast_4
  DEFW spr_alien_blast_5
  DEFW spr_alien_blast_4
  DEFW spr_alien_blast_3
  DEFW spr_alien_blast_2
  DEFW spr_alien_blast_1
  DEFW spr_alien_blast_1

; Анимация UFO
anim_ufo:
  DEFW spr_ufo_1
  DEFW spr_ufo_2
  DEFW spr_ufo_3
  DEFW spr_ufo_4
  DEFW spr_ufo_5
  DEFW spr_ufo_6
  DEFW spr_ufo_5
  DEFW spr_ufo_4
  DEFW spr_ufo_3
  DEFW spr_ufo_2