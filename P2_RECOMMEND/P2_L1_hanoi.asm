.data
	mark1: .asciiz "move disk "
	mark2: .asciiz " from "
	mark3: .asciiz " to "
	enter: .asciiz "\n"
	
.macro getChar(%dest)
	li $v0,12
	syscall
	move %dest,$v0
.end_macro

.macro printStrOf(%src)
	la $a0, %src
	li $v0, 4
	syscall
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

.macro get_vector_addr(%index, %x)
    sll     %index, %x, 2
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
	move $a0,$s0
	li $t1,65
	move $a1,$t1
	li $t1,66
	move $a2,$t1
	li $t1,67
	move $a3,$t1
	
	jal hanoi


	li $v0,10
	syscall
	
	
	hanoi:
	#1: push
		push($ra)
		push($t0)
		push($t1)
		push($t2)
		push($t3)
		
		
	#2: move args
		move $t0,$a0
		move $t1,$a1
		move $t2,$a2
		move $t3,$a3
	#3: body
		bnez $t0,if_end
		
			move $a0,$t0
			move $a1,$t1
			move $a2,$t2
			jal move_
		
			move $a0,$t0
			move $a1,$t2
			move $a2,$t3
			jal move_
			
			j pop_and_return
		
		
		if_end:
		
			move $a0,$t0
			subi $a0,$a0,1
			move $a1,$t1
			move $a2,$t2
			move $a3,$t3
			jal hanoi
		
			move $a0,$t0
			move $a1,$t1
			move $a2,$t2
			jal move_
			
			move $a0,$t0
			subi $a0,$a0,1
			move $a1,$t3
			move $a2,$t2
			move $a3,$t1
			jal hanoi
			
			move $a0,$t0
			move $a1,$t2
			move $a2,$t3
			jal move_
			
			move $a0,$t0
			subi $a0,$a0,1
			move $a1,$t1
			move $a2,$t2
			move $a3,$t3
			jal hanoi
	pop_and_return:	
	#4: pop
		pop($t3)
		pop($t2)
		pop($t1)
		pop($t0)
		pop($ra)
	#5: return
		jr $ra
	
	
	
	move_:
	#1: push
		push($ra)
		push($t0)
		push($t1)
		push($t2)
	#2: move args
		move $t0,$a0
		move $t1,$a1
		move $t2,$a2
	#3: body
		printStrOf(mark1)
		printInt($t0)
		printStrOf(mark2)
		printChar($t1)
		printStrOf(mark3)
		printChar($t2)
		printStrOf(enter)
		
	#4: pop
		pop($t2)
		pop($t1)
		pop($t0)
		pop($ra)
	#5: return
		jr $ra
