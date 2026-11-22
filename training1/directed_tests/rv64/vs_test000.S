.data
fib: 
 .word 0

.text
start:
   la x1, fib
   addi x2, x1,0
loop:
   j  loop
