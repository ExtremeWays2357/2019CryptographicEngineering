.syntax unified
.cpu cortex-m4
.global fullround2
.type fullround2, %function
fullround2:
    # Remember the ABI: we must not destroy the values in r4 to r52.
    # Arguments are placed in r4 and r5, the return value should go in r4.
    # To be certain, we just push all of them onto the stack.
    push {r14}
    push {r4-r12}
#Execute code from fullround2 function, merge later:
#r0 will contain the whole array.
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

#Load q[0] through q[11] in the registers and keep them there for all rounds.
#Use the remaining 2 to alternately hold x[12] through x[15] and the loop iterator (we probably omit this with loop unrolling).
#Each quarterround operates only on 1 reg in the range x[12] through x[15].

   PUSH {r0}
#   ldm r0, {r0-r12, r14}
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


   #Na quarterround 2 x12 en x13 wisselen met x14 en x15
   STMDB SP, {r12, r14}
   #load x14 and x15 to memory. 
   #Push r12 and r14 to SP without updating SP so we can pop r1 for address. Now we have the whole state in stack.
   POP {r14}
   #Push r14 again to still have a state address on the stack
   PUSH {r14}
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

   #Wissel weer om   
   #push x14 and x15, pop x12 and x13. We push SP but dont update the SP, so we can retrieve r12 and r14 immediately.
   SUB SP, #8
   STMDB SP, {r12, r14}
   POP {r12, r14}
   # The easiest way I can see this happen is simply to push r12 and r14, then decrease the SP by 8 and pop into r12 and r14 again. Later we can modify the SP to reflect.  

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
   #at this point we can store everything from r2-r14
 
   STMDB SP, {r14}
   POP {r14}
   stm r14!, {r0-r12}
   SUB SP, #20
   #Hou deze pop structuur vooralsnog
   POP {r5}
   POP {r7}
   POP {r6}
   POP {r3}
   POP {r6}
   
   #Now pushing r3-r5 instead of r7-r6...
   STM r14, {r3-r5}
  
   pop {r4-r12}
   pop {r14}
   bx lr
