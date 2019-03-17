.syntax unified
.cpu cortex-m4
.global fullround3
.type fullround3, %function
fullround3:
  push {r14}
  push {r4-r12}

 ldm r0, {r1-r12, r14}

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

  #fr 4
  #fr 4 qr 1
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

   #fr 4 qr 2
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

  #fr 4 qr 3
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

  #fr 4 qr 4
   add r2, r2, r7, ror #25
   eor r14, r2, r14, ror #24

   add r12, r12, r14, ror #16
   eor r7, r12, r7, ror #25

   add r2, r2, r7, ror #20
   eor r14, r2, r14, ror #16

   add r12, r12, r14, ror #24
   eor r7, r12, r7, ror #20

  #full round 5
   #fr 5 qr 1
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

  #fr 5 qr 2
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

  #fr 5 qr 3
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
  
  #fr 5 qr 4
   add r4, r4, r8, ror #25
   eor r14, r4, r14, ror #24

   add r12, r12, r14, ror #16
   eor r8, r12, r8, ror #25

   add r4, r4, r8, ror #20
   eor r14, r4, r14, ror #16

   add r12, r12, r14, ror #24
   eor r8, r12, r8, ror #20

  #full round 6
  #fr 6 qr 1
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

   #fr 6 qr 2
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

  #fr 6 qr 3
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

  #fr 6 qr 4
   add r2, r2, r7, ror #25
   eor r14, r2, r14, ror #24

   add r12, r12, r14, ror #16
   eor r7, r12, r7, ror #25

   add r2, r2, r7, ror #20
   eor r14, r2, r14, ror #16

   add r12, r12, r14, ror #24
   eor r7, r12, r7, ror #20

  #full round 7
   #fr 7 qr 1
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

  #fr 7 qr 2
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

  #fr 7 qr 3
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
  
  #fr 7 qr 4
   add r4, r4, r8, ror #25
   eor r14, r4, r14, ror #24

   add r12, r12, r14, ror #16
   eor r8, r12, r8, ror #25

   add r4, r4, r8, ror #20
   eor r14, r4, r14, ror #16

   add r12, r12, r14, ror #24
   eor r8, r12, r8, ror #20


  #full round 8
  #fr 8 qr 1
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

   #fr 8 qr 2
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

  #fr 8 qr 3
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

  #fr 8 qr 4
   add r2, r2, r7, ror #25
   eor r14, r2, r14, ror #24

   add r12, r12, r14, ror #16
   eor r7, r12, r7, ror #25

   add r2, r2, r7, ror #20
   eor r14, r2, r14, ror #16

   add r12, r12, r14, ror #24
   eor r7, r12, r7, ror #20

  #full round 9
   #fr 9 qr 1
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

  #fr 9 qr 2
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

  #fr 9 qr 3
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
  
  #fr 9 .qr 4
   add r4, r4, r8, ror #25
   eor r14, r4, r14, ror #24

   add r12, r12, r14, ror #16
   eor r8, r12, r8, ror #25

   add r4, r4, r8, ror #20
   eor r14, r4, r14, ror #16

   add r12, r12, r14, ror #24
   eor r8, r12, r8, ror #20

  #full round 10
  #fr 10 qr 1
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

   #fr 10 qr 2
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

  #fr 10 qr 3
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

  #fr 10 qr 4
   add r2, r2, r7, ror #25
   eor r14, r2, r14, ror #24

   add r12, r12, r14, ror #16
   eor r7, r12, r7, ror #25

   add r2, r2, r7, ror #20
   eor r14, r2, r14, ror #16

   add r12, r12, r14, ror #24
   eor r7, r12, r7, ror #20

  #full round 11
   #fr 11 qr 1
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

  #fr 11 qr 2
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

  #fr 11 qr 3
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
  
  #fr 11 qr 4
   add r4, r4, r8, ror #25
   eor r14, r4, r14, ror #24

   add r12, r12, r14, ror #16
   eor r8, r12, r8, ror #25

   add r4, r4, r8, ror #20
   eor r14, r4, r14, ror #16

   add r12, r12, r14, ror #24
   eor r8, r12, r8, ror #20


  #fr 12
  #fr 12 qr 1
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

   #fr 12 qr 2
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

  #fr 12 qr 3
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

  #fr 12 qr 4
   add r2, r2, r7, ror #25
   eor r14, r2, r14, ror #24

   add r12, r12, r14, ror #16
   eor r7, r12, r7, ror #25

   add r2, r2, r7, ror #20
   eor r14, r2, r14, ror #16

   add r12, r12, r14, ror #24
   eor r7, r12, r7, ror #20

  #full round 5
   #fr 13 qr 1
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

  #fr 13 qr 2
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

  #fr 13 qr 3
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
  
  #fr 13 qr 4
   add r4, r4, r8, ror #25
   eor r14, r4, r14, ror #24

   add r12, r12, r14, ror #16
   eor r8, r12, r8, ror #25

   add r4, r4, r8, ror #20
   eor r14, r4, r14, ror #16

   add r12, r12, r14, ror #24
   eor r8, r12, r8, ror #20

  #full round 6
  #fr 14 qr 1
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

   #fr 14 qr 2
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

  #fr 14 qr 3
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

  #fr 14 qr 4
   add r2, r2, r7, ror #25
   eor r14, r2, r14, ror #24

   add r12, r12, r14, ror #16
   eor r7, r12, r7, ror #25

   add r2, r2, r7, ror #20
   eor r14, r2, r14, ror #16

   add r12, r12, r14, ror #24
   eor r7, r12, r7, ror #20

  #full round 7
   #fr 15 qr 1
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

  #fr 15 qr 2
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

  #fr 15 qr 3
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
  
  #fr 15 qr 4
   add r4, r4, r8, ror #25
   eor r14, r4, r14, ror #24

   add r12, r12, r14, ror #16
   eor r8, r12, r8, ror #25

   add r4, r4, r8, ror #20
   eor r14, r4, r14, ror #16

   add r12, r12, r14, ror #24
   eor r8, r12, r8, ror #20


  #full round 8
  #fr 16 qr 1
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

   #fr 16 qr 2
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

  #fr 16 qr 3
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

  #fr 16 qr 4
   add r2, r2, r7, ror #25
   eor r14, r2, r14, ror #24

   add r12, r12, r14, ror #16
   eor r7, r12, r7, ror #25

   add r2, r2, r7, ror #20
   eor r14, r2, r14, ror #16

   add r12, r12, r14, ror #24
   eor r7, r12, r7, ror #20

  #full round 9
   #fr 17 qr 1
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

  #fr 17 qr 2
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

  #fr 17 qr 3
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
  
  #fr 17 .qr 4
   add r4, r4, r8, ror #25
   eor r14, r4, r14, ror #24

   add r12, r12, r14, ror #16
   eor r8, r12, r8, ror #25

   add r4, r4, r8, ror #20
   eor r14, r4, r14, ror #16

   add r12, r12, r14, ror #24
   eor r8, r12, r8, ror #20

  #full round 10
  #fr 18 qr 1
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

   #fr 18 qr 2
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

  #fr 18 qr 3
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

  #fr 18 qr 4
   add r2, r2, r7, ror #25
   eor r14, r2, r14, ror #24

   add r12, r12, r14, ror #16
   eor r7, r12, r7, ror #25

   add r2, r2, r7, ror #20
   eor r14, r2, r14, ror #16

   add r12, r12, r14, ror #24
   eor r7, r12, r7, ror #20

  #full round 11
   #fr 19 qr 1
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

  #fr 19 qr 2
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

  #fr 19 qr 3
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
  
  #fr 19 qr 4
   add r4, r4, r8, ror #25
   eor r14, r4, r14, ror #24

   add r12, r12, r14, ror #16
   eor r8, r12, r8, ror #25

   add r4, r4, r8, ror #20
   eor r14, r4, r14, ror #16

   add r12, r12, r14, ror #24
   eor r8, r12, r8, ror #20

   #full round  20
  #fr 20 qr 1
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

   #fr 20 qr 2
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

  #fr 20 qr 3
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

  #fr 20 qr 4
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
