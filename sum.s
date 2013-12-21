.section .data
.section .text

.globl _start
_start:
	# sum(5, 7, 8)
	pushl    $8
	pushl    $7
	pushl    $5
	call     sum
	addl     $12, %esp

	pushl	 %eax

	pushl	 $1
	pushl    $5
	pushl    $8
	call     sum
	addl     $12, %esp

	popl     %ebx

	addl     %eax, %ebx

	movl     $1, %eax
	int      $0x80


# sum(long b, long c, long e) -> long
sum:
	pushl    %ebp
	movl     %esp, %ebp

	subl     $4, %esp

        movl     8(%ebp), %eax
	movl     12(%ebp), %ebx
	movl     16(%ebp), %ecx

	addl    %ebx, %eax
        addl    %ecx, %eax

	movl    %ebp, %esp
	popl    %ebp
	ret
