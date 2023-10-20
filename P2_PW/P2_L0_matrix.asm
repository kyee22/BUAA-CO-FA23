.data
	A: 		.space 400
	B: 		.space 400
	C: 		.space 400
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
	li %ans,10
	multu %row, %ans
	mflo %ans
	addu %ans,%ans,%col
	sll %ans,%ans,2
.end_macro


	


.text
	getInt($s0) # $s0 = n
	
	#################### read A ####################
	li $t0,0
	for_1_i_begin:
		bge $t0,$s0,for_1_i_end
		
		li $t1,0
		for_1_j_begin:
			bge $t1,$s0,for_1_j_end
			
			get_matrix_addr($t2,$t0,$t1)
			getInt($t3)
			sw $t3,A($t2)
			
			
			addi $t1,$t1,1
			j for_1_j_begin
		for_1_j_end:
		
		
		addi $t0,$t0,1
		j for_1_i_begin
	for_1_i_end:
	
	#################### read B ####################
	li $t0,0
	for_2_i_begin:
		bge $t0,$s0,for_2_i_end
		
		li $t1,0
		for_2_j_begin:
			bge $t1,$s0,for_2_j_end
			
			get_matrix_addr($t2,$t0,$t1)
			getInt($t3)
			sw $t3,B($t2)
			
			
			addi $t1,$t1,1
			j for_2_j_begin
		for_2_j_end:
		
		
		addi $t0,$t0,1
		j for_2_i_begin
	for_2_i_end:
	
	#################### calculate: A * B ####################
	li $t0,0
	for_3_i_begin:
		bge $t0,$s0,for_3_i_end
		
		li $t1,0
		for_3_j_begin:
			bge $t1,$s0,for_3_j_end
			
			li $t3,0 # C[i][j] = 0
			
			li $t2,0
			for_3_k_begin:
				bge $t2,$s0,for_3_k_end
				
				get_matrix_addr($t4,$t0,$t2) # (i,k)
				lw $t5,A($t4)	# $t5 = A[i][k]
				get_matrix_addr($t4,$t2,$t1) # (k,j)
				lw $t6,B($t4)	# $t6 = B[k][j]
				
				multu $t5,$t6
				mflo $t5
				addu $t3,$t3,$t5
				
				
				addi $t2,$t2,1
				j for_3_k_begin
			for_3_k_end:
			
			printInt($t3)
			printStrOf(space)
			
			
			addi $t1,$t1,1
			j for_3_j_begin
		for_3_j_end:
		
		printStrOf(enter)
		
		addi $t0,$t0,1
		j for_3_i_begin
	for_3_i_end:
	
	
	# exit
	li $v0, 10
	syscall
