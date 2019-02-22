.syntax unified
.cpu cortex-m4

.data
#some globals, for example:
#somedata:
# .doubleword 0x123456789abcdef
# .word 0x12345678
# .halfword 0x1234
# .byte 0x2a
# .nibble 0xf

.text
.global quarterround2
.type quarterround2, %function
quarterround2:
    # Remember the ABI: we must not destroy the values in r4 to r12.
    # Arguments are placed in r0 and r1, the return value should go in r0.
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

#According to conventions, r0 through r3 contain the arguments of the function call (so a, b, c and d respectively)
#ARM does not contain a rotate-left instruction, so we simulate using a LSL of X and an LSR of 32-X. 
#Noël was being stupid, we can just rotate with 32-X instead of doing annoying shifts. Not used to having rotate instructions that are useful
   add r0, r0, r1
   eor r3, r3, r0
   ror r3, r3, 16
   #lsl r5, r3, #16
   #eor r3, r5, r3, lsr #16
   #could rotate ^ but for now, lets just keep shifting until it we have no regression faults.
   
   add r2, r2, r3
   eor r1, r1, r2
   ror r1, r1, #20
   #lsl r5, r1, #12
   #eor r1, r5, r1, lsr #20 

   add r0, r0, r1
   eor r3, r3, r0
   ror r3, r3, #24
   #lsl r5, r3, #8
   #eor r3, r5, r3, lsr #24

   add r2, r2, r3
   eor r1, r1, r2
   ror r1, r1, #25
   #lsl r5, r1, #7
   #eor r1, r5, r1, lsr #25

   # Finally, we restore the callee-saved register values and branch back.
    pop {r4-r12}
    bx lr
