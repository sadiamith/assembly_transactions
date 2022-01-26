.data
    promptStr: .asciiz "Enter an integer"
    outStr: .asciiz "The sum is: "

.text

main:

    li $v0, 4          
    la, $a0, promptStr
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 4
    la, $a0, promptStr
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    add $t2, $t0, $t1

    li $v0, 4
    la, $a0, outStr
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 10
    syscall