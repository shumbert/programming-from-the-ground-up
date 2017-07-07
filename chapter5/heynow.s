 .section .data
filename:
 .string "heynow.txt"
string:
 .string "Hey diddle diddle!\n"
length:
 .long 19

 .equ SYS_EXIT, 1
 .equ SYS_READ, 3
 .equ SYS_WRITE, 4
 .equ SYS_OPEN, 5
 .equ SYS_CLOSE, 6
 
 .equ O_CREAT_WRONLY_TRUNC, 03101
 
 .equ LINUX_SYSCALL, 0x80
 .equ END_OF_FILE, 0
 .equ NUMBER_ARGUMENTS, 2

 .section .bss
 .lcomm ST_FD_OUT, 4

 .section .text

 .globl _start
_start:
 movl %esp, %ebp

 movl $SYS_OPEN, %eax
 movl $filename, %ebx
 movl $O_CREAT_WRONLY_TRUNC, %ecx
 movl $0666, %edx
 int $LINUX_SYSCALL
 movl %eax, ST_FD_OUT

 movl $SYS_WRITE, %eax
 movl ST_FD_OUT, %ebx
 movl $string, %ecx
 movl length, %edx
 int $LINUX_SYSCALL

 movl $SYS_CLOSE, %eax
 movl ST_FD_OUT, %ebx
 int $LINUX_SYSCALL

 movl $SYS_EXIT, %eax
 movl $0, %ebx
 int $LINUX_SYSCALL
