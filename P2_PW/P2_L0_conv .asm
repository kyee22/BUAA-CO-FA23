.data
	M: 		.space 1000
	core: 	.space 400
	space: 	.asciiz " "
	enter: 	.asciiz "\n"

.macro getInt(%dest)
	li $v0, 5
	syscall
	move %dest, $v0
.end_macro

.macro printInt(%src)
	move $a0, %src
	li $v0, 1
	syscall
.end_macro

.macro printStrOf(%src)
	la $a0, %src
	li $v0, 4
	syscall
.end_macro

.macro get_matrix_addr(%ans, %row, %col)
	li %ans,13
	multu %row, %ans
	mflo %ans
	addu %ans,%ans,%col
	sll %ans,%ans,2
.end_macro



.text
	getInt($s0)
	getInt($s1)
	getInt($s2)
	getInt($s3)
	################# read M #################
	li $t0,1
	for_1_i_begin:
		bgt $t0,$s0,for_1_i_end
		
		li $t1,1
		for_1_j_begin:
			bgt $t1,$s1,for_1_j_end
			
			get_matrix_addr($t2,$t0,$t1)
			getInt($t3)
			sw $t3,M($t2)
		
			addi $t1,$t1,1
			j for_1_j_begin
		for_1_j_end:
		
		
		
		addi $t0,$t0,1
		j for_1_i_begin
	for_1_i_end:
	
	################# read core #################
	li $t0,1
	for_2_i_begin:
		bgt $t0,$s2,for_2_i_end
		
		li $t1,1
		for_2_j_begin:
			bgt $t1,$s3,for_2_j_end
			
			get_matrix_addr($t2,$t0,$t1)
			getInt($t3)
			sw $t3,core($t2)
		
			addi $t1,$t1,1
			j for_2_j_begin
		for_2_j_end:
		
		
		
		addi $t0,$t0,1
		j for_2_i_begin
	for_2_i_end:
	
	################# calculate #################
	subu $s6,$s0,$s2
	addi $s6,$s6,1
	
	subu $s7,$s1,$s3
	addi $s7,$s7,1
	
	li $t0,1
	for_3_i_begin:
		bgt $t0,$s6,for_3_i_end
		
		li $t1,1
		for_3_j_begin:
			bgt $t1,$s7,for_3_j_end
			
			li $s5,0
			
			li $t2,1
			for_3_k_begin:
				bgt $t2,$s2,for_3_k_end
				
				li $t3,1
				for_3_l_begin:
					bgt $t3,$s3,for_3_l_end
					
					addu $t4,$t0,$t2
					subi $t4,$t4,1
					addu $t5,$t1,$t3
					subi $t5,$t5,1
					get_matrix_addr($t6,$t4,$t5)
					lw $t7,M($t6)
					
					get_matrix_addr($t6,$t2,$t3)
					lw $t8,core($t6)
					
					multu $t7,$t8
					mflo $t7
					
					addu $s5,$s5,$t7
					
					
					addi $t3,$t3,1
					j for_3_l_begin
				for_3_l_end:
				
				
				addi $t2,$t2,1
				j for_3_k_begin
			for_3_k_end:
			
			printInt($s5)
			printStrOf(space)
			
			
			addi $t1,$t1,1
			j for_3_j_begin
		for_3_j_end:
		
		printStrOf(enter)
		
		addi $t0,$t0,1
		j for_3_i_begin
	for_3_i_end:
	# exit
	li $v0,10
	syscall