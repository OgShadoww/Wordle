; ==============================
; UI MODULE
; ==============================
; ui_clear()
; ui_draw_board(secret, guesses)
; ui_print_colored_word(word, colors)
.global _ui_clear
.global _ui_draw_board

_ui_clear:
  mov X0, #1 
  adr X1, ansi_clear
  mov X2, 7
  mov X16, #4
  svc 0x80

  ret

_ui_draw_board:
  mov X0, #1
  adr X1, board
  mov X2, 16
  mov X16, #4
  svc 0x80

  ret

ansi_clear:
    .asciz "\x1b[2J\x1b[H"

ansi_reset:
    .asciz "\x1b[0m"

ansi_green:
  .asciz "\x1b[32m"

ansi_yellow:
  .asciz "\x1b[33m"

ansi_grey:
  .asciz "\x1b[90m"

board:
  .asciz "[ ][ ][ ][ ][ ]\n"


