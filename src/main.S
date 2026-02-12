.section __TEXT,__text
.global _main
.extern _ui_clear
.extern _ui_draw_board
.extern _print_num
.extern _exit
.extern _rand
.extern _set_secret_word

_main:
  bl _ui_clear
  bl _ui_draw_board

  bl _set_secret_word

   ; Writing result
  mov x2, x0
  mov x0, #1
  adrp x1, secret_word@PAGE
  add x1, x1, secret_word@PAGEOFF
  mov x16, #4
  svc #0x80


  bl _exit

.section __DATA,__bss
.p2align 2

.global secret_word
secret_word: .zero 6
user_word: .zero 6
