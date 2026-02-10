.global _main

.extern _get_term_size

_main:
  bl _print_board

  mov X0, #0
  mov X16, #1
  svc 0x80

_print_board:
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


