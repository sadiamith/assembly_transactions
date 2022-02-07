.data
    prompt: .asciiz "Please enter a string: "
    BannedChars: .asciiz "m$ug9%" #memory label for banned chars
    inputBuffer: .space 20 #allocating space to save user input
    outBanned: .asciiz "you entered a banned string"
    inputOkay: .asciiz "no banned chars found"

"""we need to loop over the input string and then check whether this char is"""
"""inside our banned chars or not (double loop)"""
.text
main:
    la $a0, prompt          #syscall to print out the prompt
    li $v0, 4 
    syscall    

    la $a0, inputBuffer     #gets the address of the input buffer
    li $a1, 20              #Max size of string to read
    li $v0, 8               #syscall code for reading string from the console
    syscall

    la $t0, inputBuffer     #t0 = holds the addres of the input string

input_loop: 
    lb $t2, ($t0)           #loading single char from input string to $t2 for checking
    beqz $t2, print_okay    #checking whether $t2 hit null character or not(at the end or not)
    
    la $t1, BannedChars     #loading bannedChars in $t1
banned_loop:
    lb $t3, ($t1)           #loading single char from banned string from $t1 -> $t3 for checking
    beqz $t3, done_banned_loop #we have reached at the end of the banned string 

    beq $t2, $t3, print_banned  #if the char from the input is same as banned char 
    addi $t1, $t1, 1            #incrementing pointer in banned string
    j banned_loop

done_banned_loop:
    addi $t0, $t0, 1        #if reached at the end of banendChars string, check the 2nd char of input string
    j input_loop

print_okay:
    la $a0, inputOkay
    li $v0, 4
    syscall                 #syscall to printing inputOkay string

    j done

print_banned:
    la $a0, inputOkay
    li $v0, 4
    syscall 

#syscall fpr terminating
done: 
    li $v0, 10
    syscall
