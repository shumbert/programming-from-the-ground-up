 .section .data
format: .string "%d\n"

 .section .text
 .globl _start

_start:
 pushl $0
 pushl $5
 call power
 addl $8, %esp
 pushl %eax
 pushl $format
 call printf
 addl $8, %esp
 movl $0, %ebx
 movl $1, %eax
 int $0x80

 .type power, @function
power:
 pushl %ebp
 movl %esp, %ebp
 subl $4, %esp
 movl 8(%ebp), %ebx
 movl 12(%ebp), %ecx
 movl %ebx, -4(%ebp)
 cmpl $0, %ecx
 jne power_loop_start
 movl $1, -4(%ebp)
 jmp end_power
power_loop_start:
 cmpl $1, %ecx
 je end_power
 movl -4(%ebp), %eax
 imull %ebx, %eax
 movl %eax, -4(%ebp)
 decl %ecx
 jmp power_loop_start
end_power:
 movl -4(%ebp), %eax
 movl %ebp, %esp
 popl %ebp
 ret
