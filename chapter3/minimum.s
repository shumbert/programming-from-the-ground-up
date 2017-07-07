.section .data
data_items:
 .long 3,67,34,222,45,75,54,34,44,33,2,11,66,0

.section .text

.globl _start
_start:
 movl $0, %edi
 movl $256, %ebx
 movl data_items(,%edi,4), %eax
start_loop:
 cmpl $0, %eax
 je loop_exit
 cmpl %ebx, %eax
 jge increment
 movl %eax, %ebx
increment:
 incl %edi
 movl data_items(,%edi,4), %eax
 jmp start_loop
loop_exit:
 movl $1, %eax
 int $0x80


