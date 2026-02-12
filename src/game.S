.global _set_secret_word
.extern _rand
.extern _print_num
.extern secret_word
.extern _exit

_set_secret_word:
  stp x29, x30, [sp, #-16]!
  mov x29, sp

  ; Get random number
  bl _rand
  mov x0, x0
  mov x15, x0

  ; Opening the file with words
  adrp x0, file@PAGE
  add x0, x0, file@PAGEOFF
  mov x1, #0
  mov x2, #0
  mov x16, #5
  svc #0x80

  mov x19, x0

  ; Lseek to set specific offest for the file
  mov x0, x19
  mov x14, #6
  mul x15, x15, x14
  mov x1, x15
  mov x2, #0
  mov x16, #199
  svc #0x80

  ; Reading the file
  ; Adress of variable
  mov x0, x19
  adrp x1, secret_word@PAGE
  add x1, x1, secret_word@PAGEOFF
  mov x2, #6
  mov x16, #3
  svc #0x80

  ; Writing result
  mov x2, x0
  mov x0, #1
  adrp x1, secret_word@PAGE
  add x1, x1, secret_word@PAGEOFF
  mov x16, #4
  svc #0x80
 
  ldp x29, x30, [sp], #16
  ret



file: .asciz "../words/en.txt"

;.section __DATA,__bss
;.p2align 2
