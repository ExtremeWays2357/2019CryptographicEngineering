

.text
.align 4
.global permutation
.type permutation STT_FUNC

#define globals below

#function definition
permutation:
#push regs here

._looptop
#begin loop


.bne _looptop


#pop regs

#return with the link register:
bx lr
