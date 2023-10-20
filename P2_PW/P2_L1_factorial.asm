.data
	res: .space 8000



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

.macro get_vector_addr(%index, %x)
    sll     %index, %x, 2
.end_macro


.text
	getInt($s0) #n
	
	li $s1,1		#len
	
	li $t1,0
	get_vector_addr($t2,$t1)
	sw $s1,res($t2)
	
	
	li $t0,2
	for_1_i_begin:
		bgt $t0,$s0,for_1_i_end
		
		
		li $t3,0	# carry
		
		
		li $t1,0
		for_1_j_begin:
			bge $t1,$s1,for_1_j_end
			
			get_vector_addr($t2,$t1)
			lw $t4,res($t2)
			multu $t4,$t0
			mflo $t4
			addu $t4,$t4,$t3		# $t4 = product
			
			li $t5,10
			div $t4,$t5
			
			mfhi $t6		# $t6 = remainer
			mflo $t7		# $t6 = group  ->  carry
			
			sw $t6,res($t2)
			
			move $t3,$t7
			
			addi $t1,$t1,1
			j for_1_j_begin
		for_1_j_end:
		
		while:
			ble $t3,$zero,while_end
			
			get_vector_addr($t2,$s1)
			li $t5,10
			div $t3,$t5
			
			mfhi $t6
			mflo $t7
			
			sw $t6,res($t2)
			move $t3,$t7
			
			addi $s1,$s1,1
			
			j while
		while_end:
		
		
		addi $t0,$t0,1
		j for_1_i_begin
	for_1_i_end:
	
	
	move $t0,$s1
	subi $t0,$t0,1
	for_2_begin:
		blt $t0,$zero,for_2_end
		
		get_vector_addr($t2,$t0)
		lw $t3,res($t2)
		
		printInt($t3)
		
		subi $t0,$t0,1
		j for_2_begin
	for_2_end:
	
	
	li $v0,10
	syscall
	
	