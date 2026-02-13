.section __TEXT,__text
.global _ui_clear
.global _ui_draw_board
.extern secret_word

_ui_draw_board:
  mov x17, x0 ; n
  adrp x15, secret_word@PAGE
  add x15, x15, secret_word@PAGEOFF
  mov x14, #0 ; i

_loop:
  ; Print [
  mov x0, #1
  adrp x1, board_open@PAGE
  add x1, x1, board_open@PAGEOFF
  mov x2, #1
  mov x16, #4
  svc #0x80
  
  ; If n < i
  cmp x14, x17
  b.ge _print_blank

  ; Print secret_word[i]
  mov x0, #1
  add x1, x14, x15
  mov x2, #1
  mov x16, #4
  svc #0x80
  b _fininsh_cell

_print_blank:
  mov x0, #1
  adrp x1, space@PAGE
  add x1, x1, space@PAGEOFF
  mov x2, #1
  mov x16, #4
  svc #0x80

_fininsh_cell:
  ;Print ]
  mov x0, #1
  adrp x1, board_close@PAGE
  add x1, x1, board_close@PAGEOFF
  mov x2, #1
  mov x16, #4
  svc #0x80

  add x14, x14, #1
  cmp x14, #5
  b.lt _loop

  ; Print \n
  mov x0, #1
  adrp x1, new_line@PAGE
  add x1, x1, new_line@PAGEOFF
  mov x2, #1
  mov x16, #4
  svc #0x80
  
  ret

_ui_clear:
  mov x0, #1
  adrp x1, ansi_clear@PAGE
  add x1, x1, ansi_clear@PAGEOFF
  mov x2, 7
  mov x16, #4
  svc #0x80

  ret

_ui_insert_key:
  

.section __TEXT,__cstring,cstring_literals
ansi_clear: .asciz "\x1b[2J\x1b[H"
ansi_reset: .asciz "\x1b[0m"
ansi_green: .asciz "\x1b[32m"
ansi_yellow: .asciz "\x1b[33m"
ansi_grey: .asciz "\x1b[90m"

board_open: .asciz "["
board_close: .asciz "]"
space: .asciz " "
new_line: .asciz "\n"
