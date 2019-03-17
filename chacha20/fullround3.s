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
#
#    Full round nr 1
#    quarterround2(&x[0], &x[4], &x[8],&x[12]);
#    quarterround2(&x[1], &x[5], &x[9],&x[13]);
#    quarterround2(&x[2], &x[6],&x[10],&x[14]);
#    quarterround2(&x[3], &x[7],&x[11],&x[15]);
  #fr 1 qr 1
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

  #fr 1 qr 2
   add r2, r6, r2
   eor r14, r2, r14

   add r10, r10, r14, ror #16
   eor r6, r10, r6

   add r2, r2, r6, ror #20
   eor r14, r2, r14, ror #16

   add r10, r10, r14, ror #24
   eor r6, r10, r6, ror #20

   str r14, [r0, #52]
   ldr r14, [r0, #56]

  #fr 1 qr 3
   add r3, r7, r3
   eor r14, r3, r14

   add r11, r11, r14, ror #16
   eor r7, r11, r7

   add r3, r3, r7, ror #20
   eor r14, r3, r14, ror #16

   add r11, r11, r14, ror #24
   eor r7, r11, r7, ror #20


   str r14, [r0, #56]
   ldr r14, [r0, #60]
  
#fr 1 qr 4
   add r4, r8, r4
   eor r14, r4, r14

   add r12, r12, r14, ror #16
   eor r8, r12, r8

   add r4, r4, r8, ror #20
   eor r14, r4, r14, ror #16

   add r12, r12, r14, ror #24
   eor r8, r12, r8, ror #20

  #fr 2
  #fr2 qr 1
   add r1, r1, r6, ror #25
   eor r14, r1, r14, ror #24

   add r11, r11, r14, ror #16
   eor r6, r11, r6, ror #25

   add r1, r1, r6, ror #20
   eor r14, r1, r14, ror #16

   add r11, r11, r14, ror #24
   eor r6, r11, r6, ror #20

  
   str r14, [r0, #60]
   ldr r14, [r0, #56]

   #fr2 qr 2
   add r4, r4, r5, ror #25
   eor r14, r4, r14, ror #24

   add r10, r10, r14, ror #16
   eor r5, r10, r5, ror #25

   add r4, r4, r5, ror #20
   eor r14, r4, r14, ror #16

   add r10, r10, r14, ror #24
   eor r5, r10, r5, ror #20
 
   str r14, [r0, #56]
   ldr r14, [r0, #52]

  #fr2 qr 3
   add r3, r3, r8, ror #25
   eor r14, r3, r14, ror #24

   add r9, r9, r14, ror #16
   eor r8, r9, r8, ror #25

   add r3, r3, r8, ror #20
   eor r14, r3, r14, ror #16

   add r9, r9, r14, ror #24
   eor r8, r9, r8, ror #20
 
   str r14, [r0, #52]
   ldr r14, [r0, #48]

  #fr2 qr 4
   add r2, r2, r7, ror #25
   eor r14, r2, r14, ror #24

   add r12, r12, r14, ror #16
   eor r7, r12, r7, ror #25

   add r2, r2, r7, ror #20
   eor r14, r2, r14, ror #16

   add r12, r12, r14, ror #24
   eor r7, r12, r7, ror #20

  #full round 3
   #fr 3 qr 1
   add r1, r1, r5, ror #25
   eor r14, r1, r14, ror #24

   add r9, r9, r14, ror #16
   eor r5, r9, r5, ror #25

   add r1, r1, r5, ror #20
   eor r14, r1, r14, ror #16

   add r9, r9, r14, ror #24
   eor r5, r9, r5, ror #20
 
   str r14, [r0, #48]
   ldr r14, [r0, #52] 

  #fr 3 qr 2
   add r2, r2, r6, ror #25
   eor r14, r2, r14, ror #24

   add r10, r10, r14, ror #16
   eor r6, r10, r6, ror #25

   add r2, r2, r6, ror #20
   eor r14, r2, r14, ror #16

   add r10, r10, r14, ror #24
   eor r6, r10, r6, ror #20

   str r14, [r0, #52]
   ldr r14, [r0, #56]

  #fr 3 qr 3
   add r3, r3, r7, ror #25
   eor r14, r3, r14, ror #24

   add r11, r11, r14, ror #16
   eor r7, r11, r7, ror #25

   add r3, r3, r7, ror #20
   eor r14, r3, r14, ror #16

   add r11, r11, r14, ror #24
   eor r7, r11, r7, ror #20


   str r14, [r0, #56]
   ldr r14, [r0, #60]
  
  #fr 3 qr 4
   add r4, r4, r8, ror #25
   eor r14, r4, r14, ror #24

   add r12, r12, r14, ror #16
   eor r8, r12, r8, ror #25

   add r4, r4, r8, ror #20
   eor r14, r4, r14, ror #16

   add r12, r12, r14, ror #24
   eor r8, r12, r8, ror #20

   #full round  4
  #fr 4 qr 1
   add r1, r1, r6, ror #25
   eor r14, r1, r14, ror #24

   add r11, r11, r14, ror #16
   eor r6, r11, r6, ror #25

   add r1, r1, r6, ror #20
   eor r14, r1, r14, ror #16

   add r11, r11, r14, ror #24
   eor r6, r11, r6, ror #20

   ror r14, r14, #24
   ror r6, r6, #25
  
   str r14, [r0, #60]
   ldr r14, [r0, #56]

   #fr 4 qr 2
   add r4, r4, r5, ror #25
   eor r14, r4, r14, ror #24

   add r10, r10, r14, ror #16
   eor r5, r10, r5, ror #25

   add r4, r4, r5, ror #20
   eor r14, r4, r14, ror #16

   add r10, r10, r14, ror #24
   eor r5, r10, r5, ror #20
 
   ror r14, r14, #24
   ror r5, r5, #25

   str r14, [r0, #56]
   ldr r14, [r0, #52]

  #fr 4 qr 3
   add r3, r3, r8, ror #25
   eor r14, r3, r14, ror #24

   add r9, r9, r14, ror #16
   eor r8, r9, r8, ror #25

   add r3, r3, r8, ror #20
   eor r14, r3, r14, ror #16

   add r9, r9, r14, ror #24
   eor r8, r9, r8, ror #20
 
   ror r14, r14, #24
   ror r8, r8, #25
   str r14, [r0, #52]
   ldr r14, [r0, #48]

  #fr 4 qr 4
   add r2, r2, r7, ror #25
   eor r14, r2, r14, ror #24

   add r12, r12, r14, ror #16
   eor r7, r12, r7, ror #25

   add r2, r2, r7, ror #20
   eor r14, r2, r14, ror #16

   add r12, r12, r14, ror #24
   eor r7, r12, r7, ror #20
 
   ror r14, r14, #24
   ror r7, r7, #25
 
   stm r0, {r1-r12, r14}
   
   #pop callee-saved registers
   pop {r4-r12}
   pop {r14}
   bx lr
