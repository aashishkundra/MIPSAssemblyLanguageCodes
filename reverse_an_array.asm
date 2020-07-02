.data

    array: .space 100 
    #limit is 25 numbers max
    inputPrompt: .asciiz "Enter the size of array:\n"
    enterNumbers: .asciiz "Enter the numbers...\n"
    tab: .asciiz "\t"
    printing: .asciiz "Printing the reversed array:\n"

.text

main:
    la $t0, array
    la $a1, array
    li $t1, 0
    la $a0, inputPrompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    move $t2, $v0
    la $a0, enterNumbers
    li $v0, 4
    syscall

scan:
    bge $t1, $t2, endScan
    li $v0, 5
    syscall

    sw $v0, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $t1, 1
    j scan

endScan:
    move $t3, $a1
    addi $t4, $t0, -4 

reverse:
    ble $t4, $t3, reversed
    lw $t5, 0($t3)
    lw $t6, 0($t4)
    sw $t5, 0($t4)
    sw $t6, 0($t3)
    addi $t3, $t3, 4
    addi $t4, $t4, -4
    j reverse

reversed:
    li $t1, 0

    la $a0, printing
    li $v0, 4
    syscall

printReverse:
    bge $t1, $t2, exit
    lw $a0, 0($a1)
    li $v0,1
    syscall
    
    la $a0, tab
    li $v0, 4
    syscall

    addi $a1, $a1, 4
    addi $t0, $t0, 4
    addi $t1, $t1, 1
    j printReverse

exit:
    li $v0, 10
    syscall 