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
li $v0,5
syscall
sw $v0, 0($t0)
addi $t0,$t0,4
addi $t1,$t1,1
bne $t1, $t2, scann 


la $t0, array
move $t5, $t0
addi $t1 ,$t0 , 20
move $t6, $t1

loop1:
lw $t2 , 0($t0)
move $t3, $t0
loop2:
lw $t4, 0($t3)
bge $t4, $t2,noswap
sw $t4, 0($t0)
sw $t2, 0($t3)
lw $t2, 0($t0)
noswap:
addi $t3,$t3,4
bne $t3, $t1, loop2

lw $a0, ($t0)
li $v0,1
syscall
la $a0,spacee
li $v0,4
syscall
addi $t0, $t0,4
bne $t0,$t1, loop1


li $v0, 10
syscall