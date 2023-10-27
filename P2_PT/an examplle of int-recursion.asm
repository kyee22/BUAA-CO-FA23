.data
x: .word 8888
	s: .asciiz "12345678"
	enter:	.asciiz "\n"
	
	
.macro getChar(%dest)
	li $v0,12
	syscall
	move %dest,$v0
.end_macro

.macro printChar(%src)
	li $v0,11
	move $a0,%src
	syscall
.end_macro

.macro printStrOf(%src)
	la $a0,%src
	li $v0,4
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

.macro get_matrix_addr(%ans,%row,%col)
	li %ans,10
	multu %row,%ans
	mflo %ans
	add %ans,%ans,%col
	sll %ans,%ans,2
.end_macro

.text
	getInt($s1)
	
	move $a0,$s1
	
	jal func
	
	printInt($v1)
	



	li $v0,10
	syscall
	
func:
	# 1: push
		push($ra)
		push($t0)
		push($t1)
		
		
	# 2: move args
		move $t0,$a0
	# 3: body
		li $t1,1
		bne $t0,$t1,if_end
			li $v1,1
			j pop_and_return
		if_end:
		
		
		subi $a0,$t0,1
		jal func
		
		li $t1,2
		mult $t1,$v1
		mflo $v1
		addi $v1,$v1,3
		
		
	pop_and_return:
	# 4:
		pop($t1)
		pop($t0)
		pop($ra)
	# 5:
		jr $ra