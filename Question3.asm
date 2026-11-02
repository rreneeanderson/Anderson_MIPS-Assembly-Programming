
.data
a1: .word 11, 21, 13, 32, 22
a2: .word 10, 32, 14, 19, 49
a3: .space 20
SIZE: .word 5
msg1: .asciiz "a1+a2="
eoln: .asciiz "\n"
space: .asciiz " "

.text
.globl main

main:
    la $s0, a1
    la $s1, a2
    la $s2, a3
    lw $s3, SIZE
    li $t0, 0

add_loop:
    bge $t0, $s3, print_msg

    sll $t1, $t0, 2

    add $t2, $s0, $t1
    lw $t3, 0($t2)

    add $t2, $s1, $t1
    lw $t4, 0($t2)

    add $t5, $t3, $t4

    add $t2, $s2, $t1
    sw $t5, 0($t2)

    addi $t0, $t0, 1
    j add_loop

print_msg:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 4
    la $a0, eoln
    syscall

    li $t0, 0

print_loop:
    bge $t0, $s3, done

    sll $t1, $t0, 2
    add $t2, $s2, $t1
    lw $a0, 0($t2)

    li $v0, 1
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t0, $t0, 1
    j print_loop

done:
    li $v0, 4
    la $a0, eoln
    syscall

    li $v0, 10
    syscall
