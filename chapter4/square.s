 .section .data
format: .string "%d\n"

 .section .text
 .globl _start

_start:
 pushl $3
 call square
 addl $4, %esp
 pushl %eax
 pushl $format
 call printf
 addl $8, %esp
 movl $0, %ebx
 movl $1, %eax
 int $0x80

 .type square, @function
square:
 pushl %ebp
 movl %esp, %ebp
 subl $4, %esp
 movl 8(%ebp), %ebx
 movl 8(%ebp), %eax
 imull %ebx, %eax
 movl %ebp, %esp
 popl %ebp
 ret
