.syntax unified
.cpu cortex-m4
.global quarterround2
.type quarterround2, %function
quarterround2:
    # Remember the ABI: we must not destroy the values in r4 to r52.
    # Arguments are placed in r4 and r5, the return value should go in r4.
    # To be certain, we just push all of them onto the stack.
    push {r4-r12}
    #Execute code from quarterround function, merge later:

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

#According to conventions, r0 through r3 contain the arguments of the function call (so the addresses of a, b, c and d respectively)
#ARM does not contain a rotate-left instruction, so we simulate using a LSL of X and an LSR of 32-X. 
#Noël was being stupid, we can just rotate with 32-X instead of doing annoying shifts. Not used to having rotate instructions that are useful
   ldr r4, [r0]
   ldr r5, [r1]
   ldr r6, [r2]
   ldr r7, [r3]

   add r4, r4, r5
   eor r7, r7, r4
   ror r7, r7, #16
   
   add r6, r6, r7
   eor r5, r5, r6
   ror r5, r5, #20

   add r4, r4, r5
   eor r7, r7, r4
   ror r7, r7, #24

   add r6, r6, r7
   eor r5, r5, r6
   ror r5, r5, #25

   # Finally, we restore the callee-saved register values and branch back.

   str r4, [r0]
   str r5, [r1]
   str r6, [r2]
   str r7, [r3]
   
   pop {r4-r12}
   bx lr
