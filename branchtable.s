# example of a simple calculator app implemented using a branch table (in a high level language, would be called a switch statement)
.data
    promptNumber: .asciiz "Enter a number: "
    promptOperation: .asciiz "Enter an operation (1 = add, 2 = subtract, 3 = multiply, 4 = divide): "
    promptOutput: .asciiz "The result is: "
    branch_table:                           # branch_table is an array of possible targets to jump to.
        .word do_add                        # Note this syntax sets aside one word of space, and fills it with...
        .word do_subtract                   # the address that the label (do_add, do_subtract, etc.) represents.
        .word do_multiply
        .word do_divide
.text
main:

    la $a0, promptNumber                    # Get the address of the string ready for the syscall
    li $v0, 4                               # syscall code for print string
    syscall

    li $v0, 5                               # syscall for read integer
    syscall
    move $t0, $v0                           # $t0 = input 1

    la $a0, promptNumber                    # Get the address of the string ready for the syscall
    li $v0, 4                               # syscall code for print string
    syscall

    li $v0, 5                               # syscall for read integer
    syscall
    move $t1, $v0                           # $t1 = input 2

    la $a0, promptOperation                 # Get the address of the string ready for the syscall
    li $v0, 4                               # syscall code for print string
    syscall

    li $v0, 5                               # syscall for read integer
    syscall
    move $t2, $v0                           # $t2 = operation

    # at this point, $t0 = input 1, $t1 = input 2, and $t2 = operation (1 = add, 2 = subtract, 3 = multiply, 4 = divide)

    la $t4, branch_table                    # get the starting address of the branch table

    addi $t2, $t2, -1                       # turn input (which is in range 1-4) into an index in branch_table (from 0-3)
    sll $t2, $t2, 2                         # Multiply index by 4 to get an offset in the array, since each element in...
                                            # array takes up 4 bytes.
                                            # Note this is a logical shift to the left by 2 places. For a binary number, ...
                                            # shifting 2 places is equivalent to multiplying by 2^2 = 4. (Just like shifting ...
                                            # a decimal number over 2 places is equivalent to multiplying by 10^2 = 100).
    
    add $t4, $t4, $t2                       # add starting address and offset to get final address inside branch table
    lw $t5, ($t4)                           # get the address out of the branch table ($t5 now holds address we want to go to)
    jr $t5                                  # jump to the address in $t5 (jr = jump register, jumps to an address thats in a register)


do_add:
    add $t3, $t0, $t1
    j print_output

do_subtract:
    sub $t3, $t0, $t1
    j print_output

do_multiply:
    mul $t3, $t0, $t1
    j print_output

do_divide:
    div $t3, $t0, $t1
    j print_output


print_output:
    la $a0, promptOutput                    # Get the address of the string ready for the syscall
    li $v0, 4                               # syscall code for print string
    syscall

    move $a0, $t3                           # result to print
    li $v0, 1                               # syscall for print integer
    syscall

    li $v0, 10
    syscall