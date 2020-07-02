.data
newline: .asciiz "\n"
spacee: .asciiz " "
input: .asciiz "Total numbers: "
inputnum: .asciiz "Enter a number: "
outputinorder: .asciiz "Inorder Traversal: " 

.text

main:
la $a0,input
li $v0,4
syscall
li $v0,5
syscall
move $t0, $v0
move $t1,$0
move $s0, $0  #root

scanning:
la $a0, inputnum
li $v0,4
syscall
li $v0,5
syscall
move $a0, $v0
move $a1, $s0
jal addtotree
move $s0, $v0
addi $t1, $t1, 1
bne $t0, $t1, scanning

la $a0, outputinorder
li $v0,4
syscall

move $a0, $s0
move $s1, $s0
jal inorder

li $v0,10
syscall

addtotree:
bne $a1, $0, notbasecase
move $t2, $a0
li $a0,12
li $v0,9
syscall
sw $t2, 0($v0)
sw $0, 4($v0)
sw $0, 8($v0)
jr $ra

notbasecase:
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $a1, 8($sp)

lw $t3, 0($a1)
ble $t3, $a0, right

left:
addi $s0, $a1, 4
lw $a1, 4($a1)
jal addtotree
j return

right:
addi $s0, $a1, 8
lw $a1, 8($a1)
jal addtotree

return:
#return address of child is in v0
#current node is 
sw $v0, 0($s0)
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $a1, 8($sp)
addi $sp, $sp, 12
move $v0,$a1
jr $ra

#__________________________________

inorder:
beq $a0, $0, endinorder
addi $sp, $sp, -4
sw $ra, 0($sp)

addi $sp, $sp,-4
sw $a0, 0($sp)

lw $a0, 4($a0)
jal inorder

lw $a0, 0($sp)
addi $sp, $sp,4

move $a1, $a0
lw $a0, 0($a0)
li $v0,1
syscall
la $a0, spacee
li $v0,4
syscall
move $a0, $a1

addi $sp, $sp,-4
sw $a0, 0($sp)

lw $a0, 8($a0)
jal inorder

lw $a0, 0($sp)
addi $sp, $sp,4

lw $ra, 0($sp)
addi $sp, $sp, 4
endinorder:
jr $ra
