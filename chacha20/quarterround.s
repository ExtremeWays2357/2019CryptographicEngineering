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


    mov r2, r0
    mov r0, #1
    loop:
        cmp r1, #0
        beq done
        mul r0, r2
        sub r1, #1
        b loop
    done:

    # Finally, we restore the callee-saved register values and branch back.
    pop {r4-r12}
bx lr
