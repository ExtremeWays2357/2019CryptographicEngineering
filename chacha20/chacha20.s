

.text
.align 4
.global quarterround2
.type quarterround2 STT_FUNC

#define globals below

#function definition
permutation:
#push regs here

#begin loop


#.bne _looptop


#pop regs

#return with the link register:
bx lr
