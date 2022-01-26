.data           #items below this line go into the data segment of memory (i.e variables)

A: .word 10        #sets up another space to store the number 10 into the data segment; 
                   #label A represents the address of this word





.text           #items below this line go into the text segment of memory

main:           #Colon after a word means its a label, just saying this word represents a location in memory

    li $t0, 1       #puts 1 into temp register t0
    li $t1, 2       #puts 2 into temp register t1

    la $t3, A 
    lw $t4, ($t3)

    add $t2, $t1, $t0

    li $v0, 10
    syscall