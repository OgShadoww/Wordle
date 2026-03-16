.section __TEXT,__text
.global _ui_clear
.global _ui_draw_board_center
.extern _get_term_size
.extern _move_cursor
.extern secret_word

// Draw board at the center x0 = n, x1 = word
_ui_draw_board_center:
  stp x29, x30, [sp, #-16]!
  mov x29, sp
  stp x19, x20, [sp, #-16]!

  mov x20, x0          // save n
  mov x19, x1          // save word pointer

  adrp x0, height@PAGE
  add  x0, x0, height@PAGEOFF
  adrp x1, width@PAGE
  add  x1, x1, width@PAGEOFF
  bl   _get_term_size

  adrp x3, width@PAGE
  add  x3, x3, width@PAGEOFF
  ldr  w0, [x3]          // w0 = width
  mov  w3, #2
  udiv w0, w0, w3        // w0 = width / 2
  sub w0, w0, #5

  adrp x4, height@PAGE
  add  x4, x4, height@PAGEOFF
  ldr  w1, [x4]          // w1 = height
  udiv w1, w1, w3        // w1 = height / 2
  sub w1, w1, #6

  bl   _move_cursor

  mov x0, x20
  mov x1, x19
  bl   _ui_draw_board

  ldp x19, x20, [sp], #16
  ldp x29, x30, [sp], #16
  ret

; x0 = n; x1 = word
_ui_draw_board:
  ; x0 = n; x1 = word
  mov x17, x0 ; n
  mov x15, x1
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

 _ui_print_menu:
  bl _ui_clear
  
  ; Move cursor to center

 
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

.section __DATA,__data
.p2align 3
height: .word 0
width: .word 0
