.data
spacee: .asciiz " "
newline: .asciiz "\n"
inputtotal: .asciiz "Enter the total nos in list: "
enternum: .asciiz "Enter a number: "
outputoriginal: .asciiz "\nOriginal output: "
reversed: .asciiz "\nReversed output: " 

.text
la $a0,inputtotal
li $v0,4
syscall
li $v0,5
syscall

move $t0,$v0
li $t1, 0

li $a0,8
li $v0,9
syscall
move $s0, $v0
move $s1, $s0

scanning:
la $a0,enternum
li $v0,4
syscall
li $v0,5
syscall
move $v1, $v0

beq $t1, $0, first
notfirst:
sw $s1, 4($s2)

first:
sw $v1, 0($s1)
sw $0, 4($s1)

li $a0,8
li $v0,9
syscall
move $s2, $s1
move $s1, $v0
addi $t1, $t1,1
bne $t1, $t0, scanning


move $s1,$s0

la $a0, outputoriginal
li $v0,4
syscall

printingfirst:
beq $s1, $0, bas
li $v0,1
lw $a0, 0($s1)
syscall

la $a0,spacee
li $v0,4
syscall

lw $s2, 4($s1)
move $s1, $s2
j printingfirst

bas:
move $a0,$s0         #loading arguments
lw $a1, 4($s0) 

jal reverse

la $a0, reversed
li $v0,4
syscall

printingsecond:
beq $s1, $0, printend
li $v0,1
lw $a0, 0($s1)
syscall

la $a0,spacee
li $v0,4
syscall

lw $s2, 4($s1)
move $s1, $s2
j printingsecond

printend:
li $v0,10
syscall

#______________________________________________



reverse:
addi $sp, $sp, -8
sw $ra , 0($sp)
sw $t0 , 4($sp)

move $t0, $a0
move $t1, $a1
beq $t0, $0, endrec
beq $t1, $0, endrec
lw $a2, 4($a1)
move $a0, $a1
move $a1, $a2

jal reverse

lw $t3, 4($t0)
sw $t0, 4($t3)
sw $0, 4($t0)

move $s1, $a0
endrec:
lw $ra , 0($sp)
lw $t0 , 4($sp)
addi $sp, $sp, 8
jr $ra


