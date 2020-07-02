.data
array: .space 20
#array: .word 5, 4, 3, 2, 1
newline: .asciiz "\n"
spacee: .asciiz "  "
.text

main:
la $t0,array
li $t2,5
li $t1 0
scann:
li $v0,6
syscall
lwc1 $f0, 0($t0)
addi $t0,$t0,4
addi $t1,$t1,1
bne $t1, $t2, scann 


la $t0, array
move $t5, $t0
addi $t1 ,$t0 , 20
move $t6, $t1

loop1:
lwc1 $f2 , 0($t0)
move $t3, $t0
loop2:
lwc1 $f4, 0($t3)
#bge $t4, $t2,noswap
c.ge.s $f4,$f2
bc1t noswap
swc1 $f4, 0($t0)
swc1 $f2, 0($t3)
lwc1 $f2, 0($t0)
noswap:
addi $t3,$t3,4
bne $t3, $t1, loop2

lwc1 $f12, ($t0)
li $v0,2
syscall
la $a0,spacee
li $v0,4
syscall
addi $t0, $t0,4
bne $t0,$t1, loop1


li $v0, 10
syscall