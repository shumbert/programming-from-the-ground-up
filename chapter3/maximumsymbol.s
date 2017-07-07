.section .data
data_items:
 .long 3,67,34,223,45,75,54,34,44,33,22,11,66
end_items:

.section .text

.globl _start
_start:
 lea data_items, %eax
 movl $0, %ebx
 lea end_items, %ecx
start_loop:
 cmpl %eax, %ecx
 je loop_exit
 cmpl %ebx, (%eax)
 jle increment
 movl (%eax), %ebx
increment:
 add $4, %eax
 jmp start_loop
loop_exit:
 movl $1, %eax
 int $0x80
