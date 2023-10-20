.data
	map: 	.space 4000
	used: 	.space 4000
	space: 	.asciiz " "
	enter: 	.asciiz "\n"
	mark1:	.asciiz "fail"
	mark2:	.asciiz "succeed"

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

#push
.macro push(%src)
    sw      %src, 0($sp)
    subi    $sp, $sp, 4
.end_macro
#pop
.macro pop(%des)
    addi    $sp, $sp, 4
    lw      %des, 0($sp)
.end_macro




.text
	getInt($s0)	#n
	getInt($s1)	#m
	
	li $s7,0 # ans = 0
	
	li $t0,1
	for_i_begin:
		bgt $t0,$s0,for_i_end
		
		li $t1,1
		for_j_begin:
			bgt $t1,$s1,for_j_end
			
			get_matrix_addr($t2,$t0,$t1)
			getInt($t3)
			sw $t3,map($t2)
			
			
			addi $t1,$t1,1
			j for_j_begin
		for_j_end:
		
		
		addi $t0,$t0,1
		j for_i_begin
	for_i_end:
	
	
	getInt($s2)	#src_x
	getInt($s3)	#src_y
	getInt($s4)	#target_x
	getInt($s5)	#target_y
	
	move $a0,$s2
	move $a1,$s3
	jal dfs
	
	printInt($s7)
	
	li $v0,10
	syscall
	
	dfs:
	# 1: push
		push($ra)
		push($t0)
		push($t1)
		push($t2)
		push($t3)
		push($t4)
		push($t5)
	
	# 2: move args
		move $t0,$a0
		move $t1,$a1
	# 3: function body
		#printStrOf(space)
		#printInt($t0)
		#printInt($t1)
		ble $t0,$zero,if_1
		ble $t1,$zero,if_1
		bgt $t0,$s0,if_1
		bgt $t1,$s1,if_1
		
		j if_1_end
		
		if_1:
			#printInt($t0)
			#printInt($t1)
			#printStrOf(mark1)
			#printStrOf(enter)
		pop($t5)
		pop($t4)
		pop($t3)
		pop($t2)
		pop($t1)
		pop($t0)
		pop($ra)
			jr $ra
			
		if_1_end:
		
		bne $t0,$s4,if_2_end
		bne $t1,$s5,if_2_end
		
		if_2:
			addi $s7,$s7,1
			#printInt($t0)
			#printStrOf(space)
			#printInt($t1)
			#printStrOf(mark2)
			#printStrOf(enter)
					pop($t5)
		pop($t4)
		pop($t3)
		pop($t2)
		pop($t1)
		pop($t0)
		pop($ra)
			jr $ra
		
		if_2_end:
		
		############### used[x][y]=1; ###############
		get_matrix_addr($t2,$t0,$t1)
		li $t3,1
		sw $t3,used($t2)
		
		######## [x+1][y] #######
		addi $t4,$t0,1
		move $t5,$t1
		get_matrix_addr($t2,$t4,$t5)
		lw $t3,used($t2)
		bnez $t3 judge_1_end
		lw $t3,map($t2)
		bnez $t3 judge_1_end
		
		move $a0,$t4
		move $a1,$t5
		jal dfs
		
		
		
		judge_1_end:
		######## [x-1][y] #######
		subi $t4,$t0,1
		move $t5,$t1
		get_matrix_addr($t2,$t4,$t5)
		lw $t3,used($t2)
		bnez $t3 judge_2_end
		lw $t3,map($t2)
		bnez $t3 judge_2_end
		
		move $a0,$t4
		move $a1,$t5
		jal dfs
		
		
		
		judge_2_end:
		######## [x][y+1] #######
		move $t4,$t0
		addi $t5,$t1,1
		get_matrix_addr($t2,$t4,$t5)
		lw $t3,used($t2)
		bnez $t3 judge_3_end
		lw $t3,map($t2)
		bnez $t3 judge_3_end
		
		move $a0,$t4
		move $a1,$t5
		jal dfs
		
		
		
		judge_3_end:
		######## [x][y-1] #######
		move $t4,$t0
		subi $t5,$t1,1
		get_matrix_addr($t2,$t4,$t5)
		lw $t3,used($t2)
		bnez $t3 judge_4_end
		lw $t3,map($t2)
		bnez $t3 judge_4_end
		
		move $a0,$t4
		move $a1,$t5
		jal dfs
		
		
		
		judge_4_end:
		############### used[x][y]=0; ###############
		get_matrix_addr($t2,$t0,$t1)
		li $t3,0
		sw $t3,used($t2)
	# 4: pop
		pop($t5)
		pop($t4)
		pop($t3)
		pop($t2)
		pop($t1)
		pop($t0)
		pop($ra)
	# 5: return
		jr $ra
	
	
	
