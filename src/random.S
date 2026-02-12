.section __TEXT,__text
.global _rand
.extern _get_current_ms
.extern _print_num
.extern _exit

_rand:
  stp x29, x30, [sp, #-16]!
  mov x29, sp

  bl _get_current_ms
  mov  x1, #15921
  udiv x2, x0, x1
  msub x0, x2, x1, x0

  ldp x29, x30, [sp], #16
  ret
