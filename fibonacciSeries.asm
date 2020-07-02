#fibonacci series

.data
spacee: .asciiz " "
message1: .asciiz "enter the number of values needed\n"
arr: .word 0:120

.text

la $a0,message1
li $v0,4
syscall
li $v0,5
syscall
move $t0,$v0   #t0 has number
li $t1,0
la $t2, arr
move $t3,$t2
li $t4,1
sw $t4, ($t2)
addi $t2,$t2,4
li $t5,1
sw  $t5, 0($t2)
addi $t2,$t2,4

loop:
add $t6,$t4,$t5
sw $t6,0($t2)
move $t4,$t5
move $t5,$t6
addi $t2,$t2,4
addi $t1,$t1,1
bne $t1,$t0,loop

li $t1,0
print:
li $v0,1
lw $a0, 0($t3)
syscall
la $a0,spacee
li $v0,4
syscall
addi $t1,$t1,1
addi $t3,$t3,4
bne $t1, $t0, print

li $v0,10
syscall






