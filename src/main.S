.section __TEXT,__text
.global _main
.extern _ui_clear
.extern _ui_draw_board
.extern _exit
.extern _rand
.extern _set_secret_word
.extern _read_char_to_buff

_main:
  bl _set_secret_word

  mov x0, #0
  adrp x1, user_word@PAGE
  add x1, x1, user_word@PAGEOFF
  bl _read_char_to_buff
  add x0, x0, #1
  bl _read_char_to_buff
  add x0, x0, #1
  bl _read_char_to_buff
  add x0, x0, #1
  bl _read_char_to_buff

  mov x0, #4
  adrp x1, user_word@PAGE
  add x1, x1, user_word@PAGEOFF
  bl _ui_draw_board
  
  mov x0, #0
  bl _exit

.section __DATA,__data
.p2align 3

.global secret_word
secret_word: .zero 6
user_word: .zero 6
