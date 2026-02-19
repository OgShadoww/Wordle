.global _set_secret_word
.global _read_char_to_buff
.extern _rand
.extern secret_word
.extern _ui_print_board

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

  mov x9, x0

  ; Lseek to set specific offest for the file
  mov x0, x9
  mov x14, #6
  mul x15, x15, x14
  mov x1, x15
  mov x2, #0
  mov x16, #199
  svc #0x80

  ; Reading the file
  ; Adress of variable
  mov x0, x9
  adrp x1, secret_word@PAGE
  add x1, x1, secret_word@PAGEOFF
  mov x2, #6
  mov x16, #3
  svc #0x80
 
  mov x0, x9
  mov x16, #6
  svc #0x80

  ldp x29, x30, [sp], #16
  ret

_read_char_to_buff:
  ; x0 = index (i), x1 = base pointer (word)
  mov x7, x0
  mov x8, x1

  ; Read 1 byte into stack
  sub sp, sp, #16
  mov x0, #0
  mov x1, sp
  mov x2, #1
  mov x16, #3
  svc #0x80

  cmp x0, #1
  b.ne _error

  ldrb w9, [sp]
  add sp, sp, #16
 
  cmp w9, #'\n'
  ; Prepare parameters
  mov x0, x7
  mov x1, x8
  beq _handle_return

  ; Save value from stack to word[i]
  add x8, x8, x7
  strb w9, [x8]

  ret

_handle_return:
  ; Check if the i positin is last
  cmp x0, #5
  b.ne _read_char_to_buff

  ; Write Sucess
  mov x0, #1
  adrp x1, success@PAGE
  add x1, x1, success@PAGEOFF
  mov x2, #9
  mov x16, #4
  svc #0x80

  ret

_error:
  mov x0, #-1
  add sp, sp, #16

  ret
  

file: .asciz "words/en.txt"
success: .asciz "\nSuccess\n"
