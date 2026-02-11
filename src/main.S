.section __TEXT,__text
.global _main
.extern _ui_clear
.extern _ui_draw_board
.extern _rand
.extern _print_num
.extern _exit

_main:
  bl _ui_clear
  bl _ui_draw_board
  bl _rand
  mov w0, w0
  bl _print_num

  bl _exit

.section __DATA,__bss
.p2align 2

buff: .zero 100
secret_word: .zero 6
user_word: .zero 6
