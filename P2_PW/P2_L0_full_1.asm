.data
	rec: 	.space 1000
	used: 	.space 1000
	space:	.asciiz " "
	enter:	.asciiz "\n"
	
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

.macro printStrOf(%src)
	la $a0, %src
	li $v0, 4
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

.macro get_vector_addr(%index, %x)
    sll     %index, %x, 2
.end_macro



.text
	getInt($s0)	# $s0 = n
	
	li $t0,1
	move $a0,$t0
	jal solve
	
	li $v0,10
	syscall
	
	solve:
	# 1: push
		push($ra)
		push($t0)
		push($t1)
		push($t2)
		push($t3)
		
	# 2: move args
		move $t0,$a0
	# 3 body
		ble $t0,$s0,continue
		
		li $t1,1
		for_1_begin:
			bgt $t1,$s0,for_1_end
			
			get_vector_addr($t2,$t1)
			lw $t3,rec($t2)
			printInt($t3)
			printStrOf(space)
			
			addi $t1,$t1,1
			j for_1_begin
		for_1_end:
		
		printStrOf(enter)
		
		pop($t3)
		pop($t2)
		pop($t1)
		pop($t0)
		pop($ra)
		jr $ra
		
		continue:
		
		li $t1,1
		for_2_begin:
			bgt $t1,$s0,for_2_end
			
			get_vector_addr($t2,$t1)
			lw $t3,used($t2)
			bnez $t3,go
				li $t3,1
				sw $t3,used($t2)
				
				get_vector_addr($t2,$t0)
				sw $t1,rec($t2)
			
				move $a0,$t0
				addi $a0,$a0,1
				
				jal solve
				
				get_vector_addr($t2,$t1)
				li $t3,0
				sw $t3,used($t2)
				

			
			go:
			
			
			
			addi $t1,$t1,1
			j for_2_begin
		for_2_end:
	

	# 4: pop
		pop($t3)
		pop($t2)
		pop($t1)
		pop($t0)
		pop($ra)
	# 5: 
	jr $ra
		
		
