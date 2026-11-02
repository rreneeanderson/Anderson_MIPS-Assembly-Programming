
.data
a: .word 5, 3, 2, 7, 1
space: .asciiz " "
msg: .asciiz "Sorted array: "
newline: .asciiz "\n"

.text
.globl main

main:
    la $a0, a
    li $a1, 5
    jal sort

    li $v0, 4
    la $a0, msg
    syscall

    la $t0, a
    li $t1, 0

print_loop:
    bge $t1, 5, finished

    lw $a0, 0($t0)
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t0, $t0, 4
    addi $t1, $t1, 1
    j print_loop

finished:
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall

sort:
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s0, 12($sp)
    sw $s1, 8($sp)
    sw $s2, 4($sp)
    sw $s3, 0($sp)

    move $s2, $a0
    move $s3, $a1
    li $s0, 0

outer_loop:
    bge $s0, $s3, sort_done
    addi $s1, $s0, -1

inner_loop:
    bltz $s1, next_outer

    sll $t0, $s1, 2
    add $t0, $s2, $t0
    lw $t1, 0($t0)
    lw $t2, 4($t0)

    ble $t1, $t2, next_outer

    move $a0, $s2
    move $a1, $s1
    jal swap

    addi $s1, $s1, -1
    j inner_loop

next_outer:
    addi $s0, $s0, 1
    j outer_loop

sort_done:
    lw $s3, 0($sp)
    lw $s2, 4($sp)
    lw $s1, 8($sp)
    lw $s0, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    jr $ra

swap:
    sll $t1, $a1, 2
    add $t1, $a0, $t1
    lw $t0, 0($t1)
    lw $t2, 4($t1)
    sw $t2, 0($t1)
    sw $t0, 4($t1)
    jr $ra
