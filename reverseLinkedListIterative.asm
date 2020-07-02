.data
spacee: .asciiz " "
newline: .asciiz "\n"
inputtotal: .asciiz "Enter the total nos in list: "
enternum: .asciiz "Enter a number: "
outputoriginal: .asciiz "Original output: "
reversed: .asciiz "Reversed output: " 

.text

main:
la $a0, inputtotal
li $v0,4
syscall
li $v0,5
syscall
move $t0, $v0
li $t1, 1

la $a0, enternum
li $v0,4
syscall
li $v0,5
syscall
move $v1, $v0
li $a0, 8
li $v0,9
syscall 
move $s0, $v0
sw $v1, 0($s0)
sw $0, 4($s0)           #first scanned
move $s1, $s0      #s1 iterating pointer// contains last address

scanning:
la $a0, enternum
li $v0,4
syscall
li $v0,5
syscall
move $v1,$v0
li $a0,8
li $v0,9
syscall
sw $v0, 4($s1)
sw $v1, 0($v0)
sw $0, 4($v0)
move $s1, $v0
addi $t1, $t1,1
bne $t0, $t1, scanning

la $a0,outputoriginal
li $v0,4
syscall

jal print

li $t0, 0
move $s2, $s0
lw $s3, 4($s0) 

reverse:
sw $t0, 4($s2)
move $t0, $s2
beq $s3, $0, end
lw $t4, 4($s3)
move $s2, $s3
move $s3, $t4
j reverse 

end:
move $s0, $s2

la $a0, reversed
li $v0,4
syscall

jal print
li $v0,10
syscall

#________________________

print:
addi $sp, $sp, -4
sw $s2, 0($sp)
move $s2, $s0

looop:
beq $s2,$0, ending 
lw $a0, 0($s2)
li $v0,1
syscall
la $a0,spacee
li $v0,4
syscall
lw $s2, 4($s2)
j looop


ending:
la $a0, newline
li $v0,4
syscall
lw $s2, 0($sp)
addi $sp, $sp, 4

jr $ra