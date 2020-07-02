.data
spacee: .asciiz " "
newline: .asciiz "\n"
inputtotal: .asciiz "Enter the total nos in list: "
enternum: .asciiz "Enter a number: "
outputforward: .asciiz "\nforward output: "
reversed: .asciiz "\nReversed output: " 

.text
main:
#head in s0, tail in s1
la $a0,inputtotal
li $v0,4
syscall
li $v0,5
syscall
move $t0,$v0
move $t1, $0

move $s2, $0

scanning:
la $a0, enternum
li $v0,4
syscall
li $v0,5
syscall
move $v1, $v0

li $v0,9
li $a0,12
syscall

bne $t1, $0,skip1 
move $s0, $v0 

skip1:
move $s1, $v0
sw $v1, 0($s1)
sw $0, 4($s1)
sw $s2, 8($s1)

beq $t1, $0, skip2
sw $s1, 4($s2)

skip2:
move $s2, $s1

addi $t1, $t1, 1
bne $t0, $t1, scanning

la $a0, outputforward
li $v0,4
syscall

move $s2, $s0

printforward:
beq $s2, $0, end1
lw $a0, 0($s2)
li $v0,1
syscall
la $a0, spacee
li $v0,4
syscall
lw $s2, 4($s2)
j printforward

end1:
la $a0, reversed
li $v0,4
syscall

move $s2, $s1

printbackward:
beq $s2, $0, end2
lw $a0, 0($s2)
li $v0,1
syscall
la $a0, spacee
li $v0,4
syscall
lw $s2, 8($s2)
j printbackward

end2:
li $v0,10
syscall