.data
arrtemp: .space 100
arr: .space 100
newline: .asciiz "\n"
spacee: .asciiz  " "
step: .asciiz "steps:\n"
finalans: .asciiz "final output:\n"

#______________________________________________

.text

main:
li $v0,5
syscall
move $t0,$v0
la $a0,arr
li $t1, 0 
loop:
li $v0,5
syscall
sw $v0, 0($a0)
addi $a0, $a0,4
addi $t1, $t1,1
bne $t0, $t1, loop
#scanned nos

la $a0, step
li $v0,4
syscall

la $a0, arr
li $a1, 0
addi $a2, $t0,-1

jal mergesort 

la $a0, finalans
li $v0,4
syscall

la $a1, arr
li $t1, 0 

loop1:
lw $a0, 0($a1)
li $v0,1
syscall
la $a0, spacee
li $v0,4
syscall
addi $a1, $a1,4
addi $t1, $t1,1
bne $t0, $t1, loop1

li $v0,10
syscall

#______________________________________________

mergesort:
addi $sp, $sp, -16
sw $a3, 12($sp)
sw $a1, 0($sp)
sw $a2, 4($sp)
sw $ra, 8($sp)

bge $a1, $a2, endmergesort
add $a3, $a2, $a1
li $a0, 2
div $a3, $a0
mflo $a3

addi $sp, $sp, -8
sw $a1, 0($sp)
sw $a2, 4($sp)
move $a2, $a3

jal mergesort

lw $a1, 0($sp)
lw $a2, 4($sp)
addi $sp, $sp, 8

addi $sp, $sp, -8
sw $a1, 0($sp)
sw $a2, 4($sp)
move $a1, $a3
addi $a1, $a1, 1

jal mergesort

lw $a1, 0($sp)
lw $a2, 4($sp)
addi $sp, $sp, 8

jal merge

endmergesort:
lw $a3, 12($sp)
lw $a1, 0($sp)
lw $a2, 4($sp)
lw $ra, 8($sp)
addi $sp, $sp, 16
jr $ra

#______________________________________________

merge:
addi $sp, $sp, -16
sw $a1, 0($sp)
sw $a2, 4($sp)
sw $ra, 8($sp)
sw $a3, 12($sp)

la $s0,arrtemp
la $s1,arr
li $v0,0
copyarr:
lw $s2, 0($s1)
sw $s2, 0($s0)
addi $s1,$s1,4
addi $s0,$s0,4
addi $v0,$v0,1
ble $v0,$a2, copyarr 

la $t5, arrtemp
mul $a1, $a1, 4
add $t5, $t5, $a1

la $t8, arrtemp
mul $a2, $a2, 4
add $t8, $t8, $a2

la $t6, arrtemp
mul $a3, $a3, 4
add $t6, $t6, $a3
move $t7, $t6
addi $t7, $t7, 4


#left=i=t5, midt6, mid+1=t7, right=j=t8 , k=t9
la $t9, arr
add $t9,$t9,$a1

loop3:
bgt $t5, $t6, rem1
bgt $t7, $t8, rem1

lw $s1, 0($t5)
lw $s2, 0($t7)
bge $s1, $s2, secondless

firstless:
sw $s1, 0($t9)
addi $t5, $t5, 4
addi $t9, $t9, 4
j loop3

secondless:
sw $s2, 0($t9)
addi $t7, $t7, 4
addi $t9, $t9, 4
j loop3

rem1:
bgt $t5, $t6, out
lw $s1, 0($t5)
sw $s1, 0($t9)
addi $t5, $t5, 4
addi $t9, $t9, 4
j rem1

rem2:
bgt $t7, $t8, out
lw $s2, 0($t7)
sw $s2, 0($t9)
addi $t7, $t7, 4
addi $t9, $t9, 4
j rem2


out:
jal print

lw $a1, 0($sp)
lw $a2, 4($sp)
lw $ra, 8($sp)
lw $a3, 12($sp)
addi $sp, $sp, 16
jr $ra

#______________________________________________
#printing hardcoded for 10 values
print:
addi $sp, $sp,-20
sw $a2, 0($sp)
sw $t5, 4($sp)
sw $a1, 8($sp)
sw $a0, 12($sp)
sw $v0, 16($sp) 

la $a2, arr
li $t5, 10
li $a1,0
loopp:
lw $a0, 0($a2)
li $v0,1
syscall
la $a0, spacee
li $v0,4
syscall
addi $a2, $a2,4
addi $a1, $a1,1
blt $a1, $t5, loopp 

la $a0, newline
li $v0,4
syscall

lw $a0, 12($sp)
lw $v0, 16($sp) 
lw $a1, 8($sp)
lw $a0, 0($sp)
lw $t5, 4($sp)
addi $sp, $sp,20
jr $ra