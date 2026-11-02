
.data
INIT:   .word 0
MAX:    .word 10
A:      .word 5, 9, 22, 34, 98, 56, 74, 83, 31, 22
result: .asciiz "Sum all array elements: "

.text
.globl main

main:
    lw $t0, INIT
    lw $t1, MAX
    la $t2, A
    li $t3, 0

loop:
    bge $t0, $t1, done

    sll $t4, $t0, 2
    add $t5, $t2, $t4
    lw $t6, 0($t5)
    add $t3, $t3, $t6

    addi $t0, $t0, 1
    j loop

done:
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 10
    syscall
