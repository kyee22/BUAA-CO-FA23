# MIPS递归

> 在 P2 课下做的递归都是void形递归，考前曾想过非void型怎么写，P2课上果然考了……

## 一个简单的例子

$$
f(n)=\begin{cases}1,&n=1
\\2\cdot f(n-1)+3,&n\geq 2\end{cases}
$$

输入 $n$。

输出 $f(n)$。

* C代码：

```C
#include <stdio.h>
#include <stdlib.h>

int func(int n){
    if(n==1){
        return 1;
    }

    return 2 * func(n-1) + 3;
}

int main() {
    int n;
    scanf("%d",&n);
    printf("%d\n", func(n));
    return 0;
}

```

在翻译下面这一行时

```c
    return 2 * func(n-1) + 3;
```

应先递归调用`func(n-1)`得到返回值（不妨为`$v1`），再对这个这个 返回值 进行处理得到新的 返回值（`$v0 = $v0 * 2 + 1`）

* MIPS汇编代码：

```assembly
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
```



