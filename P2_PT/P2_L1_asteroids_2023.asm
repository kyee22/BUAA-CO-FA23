.data
	aster:	.space 400
	st:		.space 400
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
	################### input ########################
	getInt($s1)
	
	li $t0,0
	for_1_begin:
		bge $t0,$s1,for_1_end
		
		get_vector_addr($t1,$t0)
		getInt($t2)
		sw $t2,aster($t1)
		
		
		addi $t0,$t0,1
		j for_1_begin
	for_1_end:
	
	
	#################### operate ######################
	li $s2,0		# pos
	li $t0,0
	for_2_begin:
		bge $t0,$s1,for_2_end
		
		li $t7,1	# alive
		
		while:
			# cond 1
			beqz $t7,while_end
			# cond 2
			get_vector_addr($t1,$t0)
			lw $t2,aster($t1)			# aster[i]
			bge $t2,$zero,while_end
			# cond 3
			ble $s2,$zero,while_end
			# cond 4
			subi $t3,$s2,1
			get_vector_addr($t1,$t3)
			lw $t4,st($t1)				# st[pos-1]
			ble $t4,$zero,while_end
			

			
			#body:
			li $t5,-1
			mult $t5,$t2
			mflo $t2		# -aster[i]
			
			slt $t7,$t4,$t2
			
			bgt $t4,$t2,if_1_end
				subi $s2,$s2,1
			if_1_end:
			
			
			
			j while
		while_end:
		
		
		beqz $t7,if_2_end
			get_vector_addr($t1,$s2)
			sw $t2,st($t1)
			
			addi $s2,$s2,1
		
		if_2_end:
		
		
		addi $t0,$t0,1
		j for_2_begin
	for_2_end:
	
	###################### output #######################
	printInt($s2)
	printStrOf(enter)
	
	li $t0,0
	for_3_begin:
		bge $t0,$s2,for_3_end
		
		get_vector_addr($t1,$t0)
		lw $t2,st($t1)
		printInt($t2)
		printStrOf(space)
		
		addi $t0,$t0,1
		j for_3_begin
	for_3_end:
	
	
	li $v0,10
	syscall