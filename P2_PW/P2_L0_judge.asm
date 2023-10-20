.data
	string: .space 1000



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

.macro get_vector_addr(%index, %x)
    sll     %index, %x, 2
.end_macro



.text
	getInt($s0)    # $s0 = n
	
	################### read string[n] ####################
	li $t0,0
	for_1_begin:
		bge $t0,$s0,for_1_end
		
		getChar($t1)
		get_vector_addr($t2,$t0)
		sw $t1,string($t2)
		
		
		addi $t0,$t0,1
		j for_1_begin
	for_1_end:
	
	#################### judge ####################
	li $s1,0			# fail_flag = 0
	li $t0,0 		# i = 0
	move $t1,$s0
	subi $t1,$t1,1		# j = n - 1
	for_2_begin:
		bgt $t0,$t1,for_2_end
		
		get_vector_addr($t2,$t0)
		lw $t3,string($t2)
		get_vector_addr($t2,$t1)
		lw $t4,string($t2)
		
		beq $t3,$t4,not_fail
		# fail:
			li $s1,1
			j for_2_end
			
		not_fail:
		
		addi $t0,$t0,1
		subi $t1,$t1,1
		j for_2_begin
	for_2_end:
	
	#################### output according to fail_flag ####################
	li $t0,1 
	beq $s1,$t0,no
		li $t0,1
		printInt($t0)
		j if_end
	no:
		li $t0,0
		printInt($t0)
		j if_end
	
	
	if_end:
	
	# exit
	li $v0, 10
	syscall