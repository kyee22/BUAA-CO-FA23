.data
	num1:	.space 400
	num2:	.space 400
	enter: .asciiz "\n"
	space:	.asciiz " "
	
	
	
	
.macro getInt(%dest)
	li $v0,5
	syscall
	move %dest,$v0
.end_macro

.macro printInt(%src)
	move $a0,%src
	li $v0,1
	syscall
.end_macro

.macro printStrOf(%src)
	la $a0,%src
	li $v0,4
	syscall
.end_macro


.macro getChar(%dest)
	li $v0,12
	syscall
	move %dest,$v0
.end_macro

.macro printChar(%src)
	move $a0,%src
	li $v0,11
	syscall
.end_macro

.macro push(%src)
	sw %src,0($sp)
	subi $sp,$sp,4
.end_macro

.macro pop(%dest)
	addi $sp,$sp,4
	lw %dest,0($sp)
.end_macro

.macro get_vector_addr(%ans,%index)
	sll %ans,%index,2
.end_macro

.text

	
	
	###################### read num1 ##########################
	getInt($s1)
		
	li $t0,0
	for_1_begin:
		bge $t0,$s1,for_1_end
		
		get_vector_addr($t1,$t0)
		getInt($t2)
		sw $t2,num1($t1)
		
		
		
		addi $t0,$t0,1
		j for_1_begin
	for_1_end:
	
	
	###################### read num1 ##########################
	getInt($s2)
	
	li $t0,0
	for_2_begin:
		bge $t0,$s2,for_2_end
		
		get_vector_addr($t1,$t0)
		getInt($t2)
		sw $t2,num2($t1)
		
		
		addi $t0,$t0,1
		j for_2_begin
	for_2_end:
	
	###################### merge ##########################
	li $t0,0
	li $t1,0
	for_3_begin:
		bge $t0,$s1,for_3_end
		bge $t1,$s2,for_3_end
		
		get_vector_addr($t2,$t0)
		lw $t3,num1($t2)	# $t3 = num[i]
		
		get_vector_addr($t2,$t1)
		lw $t4,num2($t2)	# $t4 = num[j]
		
		blt $t4,$t3,else
		
			printInt($t3)
			printStrOf(space)
			addi $t0,$t0,1
		
			j if_end
		else:
		
			printInt($t4)
			printStrOf(space)
			addi $t1,$t1,1
		
		
		if_end:
		
		
		j for_3_begin
	for_3_end:
	
	
	
	while1:
		bge $t0,$s1,while1_end
		
		get_vector_addr($t2,$t0)
		lw $t3,num1($t2)
		printInt($t3)
		printStrOf(space)		
		
		addi $t0,$t0,1
		j while1
	while1_end:
	
	
	while2:
		bge $t1,$s2,while2_end
		
		get_vector_addr($t2,$t1)
		lw $t3,num2($t2)
		printInt($t3)
		printStrOf(space)
		
		addi $t1,$t1,1
		j while2
	while2_end:
	
	
	
	li $v0,10
	syscall