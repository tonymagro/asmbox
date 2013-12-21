
.section .data
.section .text

.globl _start
_start:
	pushl   $3       # pow
	pushl   $2       # base
	call    power    # eax = power(base, pow)
	addl    $8, %esp # roll back stack pointer
	pushl   %eax     # push return value in eax onto stack

	# second power call
	pushl   $2
	pushl   $5
	call    power    # return value will be in eax
	addl    $8, %esp

	popl    %ebx     # pop result of first power call off stack and into ebx

	addl    %eax, %ebx # add results together and store in ebx

	movl    $1, %eax # sys_call for exit()
	int     $0x80    # exit will use result in ebx for return

# power(long base, long pow) -> long
.type power, @function
power:
	pushl   %ebp           # save old base pointer on stack
	movl    %esp, %ebp     # set base pointer to stack pointer
	
	# automatic variables
	subl    $4, %esp       # reserve space on stack for result - auto long result;

	# args
	movl    8(%ebp), %ebx  # base -> ebx
	movl    12(%ebp), %ecx # pow -> ecx

	movl    %ebx, -4(%ebp) # store current result on stack - result = base;

power_loop_start:
	cmpl    $1, %ecx       # if(pow == 1) 
	je      end_power      #     goto end_power;

	movl    -4(%ebp), %eax # eax = result;
	imull   %ebx, %eax     # eax = base * eax;
	movl    %eax, -4(%ebp) # result = eax;
	decl    %ecx           # pow--;
	jmp     power_loop_start

end_power:
	movl    -4(%ebp), %eax # return result;
	movl    %ebp, %esp     # reset stack pointer
	popl    %ebp           # pop save base pointer into ebp
	ret                    # return to call address	

