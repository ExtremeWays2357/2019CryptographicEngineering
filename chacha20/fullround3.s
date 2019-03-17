.syntax unified
.cpu cortex-m4
.global fullround3
.type fullround3, %function
fullround3:
  push {r14}
  push {r4-r12}

#Execute code from fullround3 function, merge later:
#r0 contains the address of the first element of the state.
#  *a = *a + *b;
#  *d = *d ^ *a;
#  *d = rotate(*d, 16);

#  *c = *c + *d;
#  *b = *b ^ *c;
#  *b = rotate(*b, 12);

#  *a = *a + *b;
#  *d = *d ^ *a;
#  *d = rotate(*d, 8);

#  *c = *c + *d;
#  *b = *b ^ *c;
#  *b = rotate(*b, 7);

   ldm r0, {r1-r12, r14}
# r14 wordt ons "dynamische register" waar we x12 t/m x15 in houden.
#
#    Full round nr 1
#    quarterround2(&x[0], &x[4], &x[8],&x[12]);
#    quarterround2(&x[1], &x[5], &x[9],&x[13]);
#    quarterround2(&x[2], &x[6],&x[10],&x[14]);
#    quarterround2(&x[3], &x[7],&x[11],&x[15]);
  #qr 1
   add r1, r5, r1
   eor r14, r1, r14

   add r9, r9, r14, ror #16
   eor r5, r9, r5

   add r1, r1, r5, ror #20
   eor r14, r1, r14, ror #16

   add r9, r9, r14, ror #24
   eor r5, r9, r5, ror #20
 
   str r14, [r0, #48]
   ldr r14, [r0, #52] 

  #qr 2
   add r2, r6, r2
   eor r14, r2, r14
   ror r14, r14, #16

   add r10, r10, r14
   eor r6, r10, r6
   ror r6, r6, #20

   add r2, r6, r2
   eor r14, r2, r14
   ror r14, r14, #24

   add r10, r10, r14
   eor r6, r10, r6
   ror r6, r6, #25

   str r14, [r0, #52]
   ldr r14, [r0, #56]

  #qr 3
   add r3, r7, r3
   eor r14, r3, r14
   ror r14, r14, #16

   add r11, r11, r14
   eor r7, r11, r7
   ror r7, r7, #20

   add r3, r7, r3
   eor r14, r3, r14
   ror r14, r14, #24

   add r11, r11, r14
   eor r7, r11, r7
   ror r7, r7, #25


   str r14, [r0, #56]
   ldr r14, [r0, #60]
  #qr 4
   add r4, r8, r4
   eor r14, r4, r14
   ror r14, r14, #16

   add r12, r12, r14
   eor r8, r12, r8
   ror r8, r8, #20

   add r4, r8, r4
   eor r14, r4, r14
   ror r14, r14, #24

   add r12, r12, r14
   eor r8, r12, r8
   ror r8, r8, #25


  #fr 2
  #qr 1
   add r1, r6, r1
   eor r14, r1, r14
   ror r14, r14, #16

   add r11, r11, r14
   eor r6, r11, r6
   ror r6, r6, #20

   add r1, r6, r1
   eor r14, r1, r14
   ror r14, r14, #24

   add r11, r11, r14
   eor r6, r11, r6
   ror r6, r6, #25

  
   str r14, [r0, #60]
   ldr r14, [r0, #56]

   #qr 2
   add r4, r4, r5, ror #25
   eor r14, r4, r14
   ror r14, r14, #16

   add r10, r10, r14
   eor r5, r10, r5, ror #25
   ror r5, r5, #20

   add r4, r5, r4
   eor r14, r4, r14
   ror r14, r14, #24

   add r10, r10, r14
   eor r5, r10, r5
   ror r5, r5, #25

 
   str r14, [r0, #56]
   ldr r14, [r0, #52]

  #qr 3
   add r3, r8, r3
   eor r14, r3, r14
   ror r14, r14, #16

   add r9, r9, r14
   eor r8, r9, r8
   ror r8, r8, #20

   add r3, r8, r3
   eor r14, r3, r14
   ror r14, r14, #24

   add r9, r9, r14
   eor r8, r9, r8
   ror r8, r8, #25 
 
   str r14, [r0, #52]
   ldr r14, [r0, #48]

  #qr 4
   add r2, r7, r2
   eor r14, r2, r14, ror #24
   ror r14, r14, #16

   add r12, r12, r14
   eor r7, r12, r7
   ror r7, r7, #20

   add r2, r7, r2
   eor r14, r2, r14
   ror r14, r14, #24

   add r12, r12, r14
   eor r7, r12, r7
   ror r7, r7, #25 
  
 
   stm r0, {r1-r12, r14}
   
   #pop callee-saved registers
   pop {r4-r12}
   pop {r14}
   bx lr
