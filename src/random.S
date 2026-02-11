.section __TEXT,__text
.global _rand
.extern _get_current_ms

_rand:
  stp x29, x30, [sp, #-16]!
  mov x29, sp

  bl _get_current_ms
  mov x1, #15921
  umulh x0, x0, x1

  ldp x29, x30, [sp], #16
  ret
