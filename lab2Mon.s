.data
	.align 2
	array: .space 40 	# defining an Array of 10 ints (10 * 4 bytes = 40)

.text

main: 
	li $t0, 0
	li $t1, 10
	la $t2, array


loop:
	sw $t0, ($t2)
	addi $t0, $t0, 1
	addi $t2, $t2, 4
	bne $t0, $t1, loop
	
	li $v0, 10
	syscall