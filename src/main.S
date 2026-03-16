.section __TEXT,__text
.global _main
.extern _ui_clear
.extern _ui_draw_board
.extern _exit
.extern _rand
.extern _set_secret_word
.extern _read_char_to_buff

_main:
  stp x29, x30, [sp, #-16]!
  mov x29, sp
  stp x19, x20, [sp, #-16]!

  bl _set_secret_word
  bl _ui_clear

  mov x19, #0

loop:
  mov x0, x19
  adrp x1, user_word@PAGE
  add  x1, x1, user_word@PAGEOFF
  bl _ui_draw_board

  mov x0, x19
  adrp x1, user_word@PAGE
  add  x1, x1, user_word@PAGEOFF
  bl _read_char_to_buff

  mov x0, x19
  adrp x1, user_word@PAGE
  add  x1, x1, user_word@PAGEOFF
  bl _ui_draw_board

  add x19, x19, #1
  cmp x19, #6
  b.lt loop

  ldp x19, x20, [sp], #16
  ldp x29, x30, [sp], #16

  mov x0, #0
  bl _exit

.section __DATA,__data
.p2align 3

.global secret_word
secret_word: .zero 6
user_word: .zero 6
