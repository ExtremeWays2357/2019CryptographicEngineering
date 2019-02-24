.syntax unified
.cpu cortex-m4
.global fullround
.type fullround, %function
fullround:
    # Remember the ABI: we must not destroy the values in r4 to r52.
    # Arguments are placed in r4 and r5, the return value should go in r4.
    # To be certain, we just push all of them onto the stack.
    push {r4-r12}
    #Execute code from fullround function, merge later:
   
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


    ldm r0, {r1-r12}
#    Full round nr 1
#    fullround2(&x[0], &x[4], &x[8],&x[12]);
#    fullround2(&x[1], &x[5], &x[9],&x[13]);
#    fullround2(&x[2], &x[6],&x[10],&x[14]);
#    fullround2(&x[3], &x[7],&x[11],&x[15]);
    
   add r1, r1, r5
   eor r13, r13, r1
   ror r13, r13, #16
   
   add r9, r9, r13
   eor r5, r5, r9
   ror r5, r5, #20

   add r1, r1, r5
   eor r13, r13, r1
   ror r13, r13, #24
   
   add r9, r9, r13
   eor r5, r5, r9
   ror r5, r5, #25

   #push x12
   push {r13} 
   #load x13
   ldr r13, [r0, #52]
 
   add r2, r2, r6
   eor r13, r13, r2
   ror r13, r13, #16
   
   add r10, r10, r13
   eor r6, r6, r10
   ror r6, r6, #20

   add r2, r2, r6
   eor r13, r13, r2
   ror r13, r13, #24
   
   add r10, r10, r13
   eor r6, r6, r10
   ror r6, r6, #25

   #push x13
   push {r13}
   #load x14
   ldr r13, [r0, #56]
   

   add r3, r3, r7
   eor r13, r13, r7
   ror r13, r13, #16
   
   add r11, r11, r13
   eor r7, r7, r11
   ror r7, r7, #20

   add r3, r3, r7
   eor r13, r13, r3
   ror r13, r13, #24
   
   add r11, r11, r13
   eor r7, r7, r11
   ror r7, r7, #25

   #push x14
   push {r13}
   #load x15
   ldr r13, [r0, #60]
   

   add r4, r4, r8
   eor r13, r13, r8
   ror r13, r13, #16
   
   add r12, r12, r13
   eor r8, r8, r12
   ror r8, r8, #20

   add r4, r4, r8
   eor r13, r13, r4
   ror r13, r13, #24
   
   add r12, r12, r13
   eor r8, r8, r12
   ror r8, r8, #25

   #store back everything to r0
   stm r0!, {r1-r12}
   pop {r12,r11, r10}
   stm r0, {r10-r13}

   pop {r4-r12}
   bx lr
