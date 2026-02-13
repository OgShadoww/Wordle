.section __TEXT,__text
.global _main
.extern _ui_clear
.extern _ui_draw_board
.extern _exit
.extern _rand
.extern _set_secret_word

_main:
  bl _set_secret_word
  
  bl _ui_clear
  mov x0, #0
  bl _ui_draw_board
  mov x0, #1
  bl _ui_draw_board
  mov x0, #2
  bl _ui_draw_board
  mov x0, #3
  bl _ui_draw_board
  mov x0, #4
  bl _ui_draw_board
  mov x0, #5
  bl _ui_draw_board

  mov x0, #0
  bl _exit

.section __DATA,__data
.p2align 3

.global secret_word
secret_word: .zero 6
l: .zero 1
