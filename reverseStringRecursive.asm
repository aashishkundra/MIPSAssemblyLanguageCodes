.data
str: .space 100
spacee: .asciiz " "
newline: .asciiz "\n"
.text

main:
la $a0,str
li $a1, 100
li $v0,8
syscall

jal length

addi $a1, $v0, -1
jal reverse

la $a0, str
li $v0,4
syscall

li $v0,10
syscall

#_______________________________

length:
 
la $a2, newline
lb $a3, 0($a2) 
move $v0, $a0
loop:
lb $t6, 0($v0)
beq $a3, $t6, terminate
addi $v0, $v0,1
j loop

terminate:
jr $ra 


#_________________________________

reverse:
addi $sp, $sp, -12
sw $ra , 0($sp)
sw $t0, 4($sp) 
sw $t1, 8($sp)

blt $a1, $a0, end
move $t0, $a0
move $t1, $a1
addi $a1, $a1, -1
addi $a0, $a0, 1
jal reverse

lb $a2, 0($t0)
lb $a3, 0($t1)
sb $a2, 0($t1)
sb $a3, 0($t0)

end:
lw $ra , 0($sp)
lw $t0, 4($sp) 
lw $t1, 8($sp)
addi $sp, $sp, 12
jr $ra