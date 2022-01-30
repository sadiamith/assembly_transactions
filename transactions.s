.data
    prompt_to_get_n: .asciiz "Please enter the number of transaction: "
    int_prompt: .asciiz "Enter N integers: "
    balance_str: .asciiz "\ntotal balance: "
    debit: .asciiz "Debit: "
    credit: .asciiz "\nCredit: "

.text

main:

    la $a0, prompt_to_get_n     #syscall to print the propmt message
    li $v0, 4
    syscall                     #syscall code to print string

    li $v0, 5                   #syscall to get inputted int from the console
    syscall
    move $t0, $v0               #moving int value to temp register t0 to keep track of how many times to loop


    la $a0, int_prompt          #syscall to print the propmt message
    li $v0, 4
    syscall

    li $t1, 0                   #initializing counter to ask for the ints n number of times

    li $t4, 0                   #initializing t4 to keep track of total balance

    li $t7, 0                   #keeps track of debits
    li $t8, 0                   #keeps track of credits

loop:
    li $v0, 5                   #syscall to read input from the console
    syscall
    move $t5, $v0               #moving the returned val from the console to t5 for doing arithmatic

    add $t4, $t4, $t5           #adding value from the console (v0) to the balance saver variable (t4) t4 = prev_t4 + t5(read value from the console)

    addi $t1, $t1, 1            #incrementing counter to break out of the loop when conditions met

    bltz $t5, isNegative
    bgtz $t5, isPositive

loop_check:
    bne $t1, $t0, loop
    
    la $a0, debit               #syscall to print out the debit str
    li $v0, 4
    syscall 

    li $v0, 1
    move $a0, $t7               #syscall to print out the debit int
    syscall

    la $a0, credit              #syscall to print out the credit str
    li $v0, 4
    syscall 

    li $v0, 1
    move $a0, $t8               #syscall to print out the credit int
    syscall

    la $a0, balance_str         #syscall to print out the balance_str
    li $v0, 4
    syscall 

    li $v0, 1
    move $a0, $t4               #syscall to print out the balance int
    syscall

    j done

isNegative:
    addi $t7, $t7, 1
    j loop_check

isPositive:
    addi $t8, $t8, 1
    j loop_check

#syscall to terminate
done:
    li $v0, 10
    syscall
