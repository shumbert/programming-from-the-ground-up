 .section .data
format:
 .ascii "The result is %d\n\0"

 .section .text
 .globl _start

_start:
 pushl $4         #The factorial takes one argument - the
                  #number we want a factorial of. So, it
                  #gets pushed
 call factorial   #run the factorial function
 addl $4, %esp    #Scrubs the parameter that was pushed on
                  #the stack
 pushl %eax
 pushl $format
 call printf

 pushl $0
 call exit
