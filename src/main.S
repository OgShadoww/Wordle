.global _main
.extern _ui_clear
.extern _ui_draw_board

_main:
  bl _ui_clear
  bl _ui_draw_board

  mov X0, #0
  mov X16, #1
  svc 0x80

  
