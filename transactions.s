.data
    prompt_to_get_n: .asciiz "Please enter the number of transaction: "
    buffer: .space 20   #sets aside 20 bytes of space for the user to input
    counter: .space 10  #number of times (N) we need to loop to get all of the transactions

.text

main:

    la $a0, prompt_to_get_n     #loadin address of the prompt to a0
    li $v0, 4
    syscall                     #syscall code to print string

    li $v0, 5                   #syscall to get inputted int from the console
    syscall
    move $t0, $v0               #moving int value to temp register t0
    sw $t0, counter             #storing the value from temp reg t0 to couter label 
