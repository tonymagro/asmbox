
.section .data
.section .text

.globl _start
_start:
	pushl	$4
	call	factorial
	addl	$4, %esp
	
	movl	%eax, %ebx
	movl	$1, %eax
	int	$0x80


factorial:
	pushl	%ebp		# store old base pointer
	movl	%esp, %ebp	# create stack frame

	movl	8(%ebp), %eax	# move first argument into eax
	cmpl	$1, %eax	# if eax is 1, return
	je	end_factorial

	decl	%eax

	pushl	%eax
	call	factorial
	movl	8(%ebp), %ebx
	imull	%ebx, %eax


end_factorial:
	movl	%ebp, %esp	# remove stack frame
	popl	%ebp		# restor old base pointer
	ret
