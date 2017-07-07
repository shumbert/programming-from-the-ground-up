 .include "linux.s"
 .include "record-def.s"

 .section .data
#Constant data of the records we want to write
#Each text data item is padded to the proper
#length with null (i.e. 0) bytes.

#.rept is used to pad each item. .rept tells
#the assembler to repeat the section between
#.rept and .endr the number of times specified.
#This is used in this program to add extra null
#characters at the end of each field to fill
#it up

record:
 .ascii "Fredrick\0"
 .rept 31 #Padding to 40 bytes
 .byte 0
 .endr

 .ascii "Bartlett\0"
 .rept 31 #Padding to 40 bytes
 .byte 0
 .endr
 
 .ascii "4242 S Prairie\nTulsa, OK 55555\0"
 .rept 209 #Padding to 240 bytes
 .byte 0
 .endr
 
 .long 45

counter:
 .long 30

#This is the name of the file we will write to
file_name:
 .ascii "test-loop.dat\0"
 .equ ST_FILE_DESCRIPTOR, -4

 .section .text
 .globl _start

_start:
 #Copy the stack pointer to %ebp
 movl %esp, %ebp
 #Allocate space to hold the file descriptor
 subl $4, %esp

 #Open the file
 movl $SYS_OPEN, %eax
 movl $file_name, %ebx
 movl $0101, %ecx #This says to create if it
                  #doesn’t exist, and open for
                  #writing
 movl $0666, %edx
 int $LINUX_SYSCALL

 #Store the file descriptor away
 movl %eax, ST_FILE_DESCRIPTOR(%ebp)

loop:
 cmpl $0, counter
 je end_loop

 #Write the first record
 pushl ST_FILE_DESCRIPTOR(%ebp)
 pushl $record
 call write_record
 addl $8, %esp
 
 decl counter
 jmp loop

end_loop:
 #Close the file descriptor
 movl $SYS_CLOSE, %eax
 movl ST_FILE_DESCRIPTOR(%ebp), %ebx
 int $LINUX_SYSCALL

 #Exit the program
 movl $SYS_EXIT, %eax
 movl $0, %ebx
 int $LINUX_SYSCALL
