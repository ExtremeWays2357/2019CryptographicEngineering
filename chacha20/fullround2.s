.syntax unified
.cpu cortex-m4
.global fullround2
.type fullround2, %function
fullround2:
  push {r14}
  push {r4-r12}

#Execute code from fullround2 function, merge later:
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

#Use the remaining 2 to alternately hold x[12] through x[15] and the loop iterator (we probably omit this with loop unrolling).
#Each quarterround operates only on 1 reg in the range x[12] through x[15].

#Push r0 on the stack to remember the address to store our result in. Laod the first 14 segments of the state
   PUSH {r0}
   ldm r0, {r0-r12, r14}
   ldm r0, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r14}
#
#    Full round nr 1
#    quarterround2(&x[0], &x[4], &x[8],&x[12]);
#    quarterround2(&x[1], &x[5], &x[9],&x[13]);
#    quarterround2(&x[2], &x[6],&x[10],&x[14]);
#    quarterround2(&x[3], &x[7],&x[11],&x[15]);

   add r0, r4, r0
   eor r12, r0, r12
   ror r12, r12, #16

   add r8, r8, r12
   eor r4, r8, r4
   ror r4, r4, #20

   add r0, r4, r0
   eor r12, r0, r12
   ror r12, r12, #24

   add r8, r8, r12
   eor r4, r8, r4
   ror r4, r4, #25 

   #quarterround 2
   add r1, r5, r1
   eor r14, r1, r14
   ror r14, r14, #16

   add r9, r9, r14
   eor r5, r9, r5
   ror r5, r5, #20

   add r1, r5, r1
   eor r14, r1, r14
   ror r14, r14, #24

   add r9, r9, r14
   eor r5, r9, r5
   ror r5, r5, #25

   #After quarterround 2, we switch x12 and x13 with x14 and x15 (while also keeping the state-address on the stack)
   
   #Store r12, r14 without incrementing the SP. This allows us to pop from SP to return the state-address. 
   STMDB SP, {r12, r14}
   
   #load x14 and x15 to memory. 
   POP {r14}
   
   #Push r14 again to still have the state-address on the stack
   PUSH {r14}
   #Load from the state address with offset. #56 = 'r0' + 14n and #60 = 'r0' + 15n, i.e. this SHOULD load x14 and x15 from the state.
   ldr r12, [r14, #56]
   ldr r14, [r14, #60]
 
   #quarterround 3
   add r2, r6, r2
   eor r12, r2, r12
   ror r12, r12, #16

   add r10, r10, r12
   eor r6, r10, r6
   ror r6, r6, #20

   add r2, r6, r2
   eor r12, r2, r12
   ror r12, r12, #24

   add r10, r10, r12
   eor r6, r10, r6
   ror r6, r6, #25

   #quarterround 4
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

   #Now full round 2? 
   # quarterround2(&x[3], &x[4], &x[9],&x[14]);
   # quarterround2(&x[0], &x[5],&x[10],&x[15]);
   # quarterround2(&x[1], &x[6],&x[11],&x[12]);
   # quarterround2(&x[2], &x[7], &x[8],&x[13]);

   #first quarterround of full round 2
   add r3, r4, r3
   eor r12, r3, r12
   ror r12, r12, #16

   add r9, r9, r12
   eor r4, r9, r4
   ror r4, r4, #20

   add r3, r4, r3
   eor r12, r3, r12
   ror r12, r12, #24

   add r9, r9, r12
   eor r4, r9, r4
   ror r4, r4, #25

   #quarterround 2 of full round 2
   add r0, r5, r0
   eor r14, r0, r14
   ror r14, r14, #16

   add r10, r10, r14
   eor r5, r10, r5
   ror r5, r5, #20

   add r0, r5, r0
   eor r14, r0, r14
   ror r14, r14, #24

   add r10, r10, r14
   eor r5, r10, r5
   ror r5, r5, #25

   #Switch x14 and x15 for x12 and x13 again. We have to play a bit with the SP to be able to push/pop at the correct locations 
   SUB SP, #8
   STMDB SP, {r12, r14}
   POP {r12, r14}
  
   #quarterround 3 of full round 2
   add r1, r6, r1
   eor r12, r1, r12
   ror r12, r12, #16

   add r11, r11, r12
   eor r6, r11, r6
   ror r6, r6, #20

   add r1, r6, r1
   eor r12, r1, r12
   ror r12, r12, #24

   add r11, r11, r12
   eor r6, r11, r6
   ror r6, r6, #25

   #quarterround 4 of full round 2  
   add r2, r7, r2
   eor r14, r2, r14
   ror r14, r14, #16

   add r8, r8, r14
   eor r7, r8, r7
   ror r7, r7, #20

   add r2, r7, r2
   eor r14, r2, r14
   ror r14, r14, #24

   add r8, r8, r14
   eor r7, r8, r7
   ror r7, r7, #25 
  
   #at this point we can store everything from r0-r12, but we still need to laod the state-address to store to.
   STMDB SP, {r14}
   POP {r14}
   stm r14!, {r0-r12}
   #Set stack pointer to the end of the stack, to pop everything gracefully.
   SUB SP, #20
   #We pop twice into r6 just to increase the SP. Ergo: r3-r4-r5 will contain x13-x14-x15
   POP {r5}
   POP {r4}
   POP {r6}
   POP {r3}
   POP {r6}
   
   #We stored to r14 with writeback the previous time around, so we can store multiple without offset here.
   STM r14, {r3-r5}
   
   #pop callee-saved registers
   pop {r4-r12}
   pop {r14}
   bx lr
