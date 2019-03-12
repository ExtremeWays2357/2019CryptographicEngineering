# (i, j, k, l) = QR(a, b, c, d)

# (i,j,k,l) = QR(S[0], S[4], S[08], S[12])

   # postc.: $e staat hierna in r0
   # e = a + b
   add r0, r4, r0
   # postc.: $h staat in r12
   # h = (d XOR e) << 16
   eor r12, r0, r12
   ror r12, r12, #16

   # postc.: $g staat in r8
   #g = c + h
   add r8, r12, r8
   # postc.: $f staat in r4
   # f = (b XOR g) << 12
   eor r4, r8, r4
   ror r4, r4 #20

   # postc.: $i staat in r0 (waar eerst e stond)
   # i = e + f
   add r0, r4, r0
   # postc.: $l staat in r12 (waar eerst h stond)
   # l = (h XOR i) << 8
   eor r12, r0, r12
   ror r12, r12, #24

   # postc.: $k staat in r8 (waar eerst g stond)
   # k = g + l
   add r8, r12, r8
   # postc.: $j staat in r4 (waar eerst f stond)
   # j = (f XOR k) << 7
   eor r4, r8, r4
   ror r4, r4, #25

# -------------------
# POSTCONDITION AFTER FIRST QUARTERROUND:
# (i,j,k,l) = (r0, r4, r8, r12)


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

