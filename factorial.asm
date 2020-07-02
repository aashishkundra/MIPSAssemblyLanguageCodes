.data
enter: .asciiz "Enter the number: "
result: .asciiz "\nThe factorial is: " 

.text

main:

	li $v0,4
	la $a0,enter
	syscall
	
	li $v0,5
	syscall

	move $a0,$v0
	li $v0,1
	jal factorial
	move $t0,$v0

	li $v0, 4
	la $a0, result
	syscall

	move $a0,$t0
	li $v0,1
	syscall

	li $v0,10
	syscall

factorial:
	
	addi $sp,$sp, -12
	sw $ra ,0($sp)
	sw $s0 , 4($sp)
	sw $a0, 8($sp)

	beq $a0,$0, ret
	move $s0,$a0
	addi $a0,$a0,-1
	jal factorial
	mul $v0,$v0,$s0

	ret:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $a0, 8($sp)
	addi $sp,$sp,12
	jr $ra





