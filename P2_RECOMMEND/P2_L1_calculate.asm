.data
	letter: .space 1000
	cnt: .space 1000
	space: .asciiz " "
	enter: .asciiz "\n"



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

.macro get_vector_addr(%index, %x)
    sll     %index, %x, 2
.end_macro

.text
	getInt($s0)
	
	li $s2,10
	li $s3,0
	
	li $t0,0
	for_1_begin:
		bge $t0,$s0,for_1_end
		
		getChar($t1)

		
		li $s4,0 #flag
		li $t2,0
		for_j_begin:
			bge $t2,$s3,for_j_end
			
			# if letter[j]==char
			get_vector_addr($t3,$t2)
			lw $t4,letter($t3)
			
			bne $t4,$t1,else
				lw $t5,cnt($t3)
				addi $t5,$t5,1
				sw $t5,cnt($t3)
				li $s4,1
				j for_j_end
			else:
			
			addi $t2,$t2,1
			j for_j_begin
		for_j_end:
		
		bnez $s4,flag_is_1
			get_vector_addr($t3,$s3)
			sw $t1,letter($t3)
			li $t1,1
			sw $t1,cnt($t3)
		
			addi $s3,$s3,1
		
		flag_is_1:
		
		
		addi $t0,$t0,1
		j for_1_begin
	for_1_end:
	
	li $t0,0
	for_2_begin:
		bge $t0,$s3,for_2_end
		
		get_vector_addr($t1,$t0)
		
		lw $t2,letter($t1)
		printChar($t2)
		printStrOf(space)
		lw $t2,cnt($t1)
		printInt($t2)
		printStrOf(enter)
		
		addi $t0,$t0,1
		j for_2_begin
	for_2_end:
	
	li $v0,10
	syscall
	