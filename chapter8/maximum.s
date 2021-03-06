 .section .data
data_items:
 .long 3,67,34,222,45,75,54,34,44,33,22,11,66,0
format_string:
 .ascii "The result is %d\n\0"

 .section .text
 .globl _start

_start:
 movl $0, %edi                  # move 0 into the index register
 movl data_items(,%edi,4), %eax # load the first byte of data
 movl %eax, %ebx                # since this is the first item, %eax is the biggest

start_loop:                     # start loop
 cmpl $0, %eax                  # check to see if we’ve hit the end
 je loop_exit
 incl %edi                      # load next value 
 movl data_items(,%edi,4), %eax
 cmpl %ebx, %eax                # compare values
 jle start_loop                 # jump to loop beginning if the new one isn't bigger
 movl %eax, %ebx                # move the value as the largest
 jmp start_loop                 # jump to loop beginning

loop_exit:
 pushl %ebx
 pushl $format_string
 call printf

 movl $1, %eax                  # 1 is the exit() syscall
 movl $0, %ebx                  # 1 is the exit() syscall
 int $0x80
