.data
    promptStr: .asciiz "Enter an int: "
    outStr: .asciiz "The sum is: "

.text

main:

    # Prompt user for first integer
    li $v0, 4               # Syscall code for printing a string
    la, $a0, promptStr      # Address of string to print
    syscall

    # Saves console input into $t0
    li $v0, 5               # syscall code for read int
    syscall
    move $t0, $v0           # first integer value

    # Prompt user for second integer
    li $v0, 4               # Syscall code for printing a string
    la, $a0, promptStr      # Address of string to print
    syscall

    # Saves console input into $t1
    li $v0, 5               # syscall code for read int
    syscall
    move $t1, $v0           # second integer value

    add $t2, $t1, $t0

    # Print out sum pre-amble
    li $v0, 4               # Syscall code for printing a string
    la, $a0, outStr         # Address of string to print
    syscall

    # Print out summed value
    li $v0, 1               # Syscall code for printing an int
    move $a0, $t2           # Place the sum in $a0 for the syscall
    syscall

    # Exit program command
    li $v0, 10
    syscall