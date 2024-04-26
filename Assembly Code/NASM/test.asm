section .data
msg1 db "Enter the first number: ",0xa
len1 equ $ - msg1
msg2 db "Enter the second number: ",0xa
len2 equ $ - msg2
msg3 db "Choose operation (1-Add, 2-Subtract, 3-Multiply, 4-Divide): ",0xa
len3 equ $ - msg3
msg4 db "Invalid operation choice.",0xa
len4 equ $ - msg4
msg5 db "The result is: ",0xa
len5 equ $ - msg5

section .bss
num1 resb 2 
len6 equ $ - num1
num2 resb 2 
len7 equ $ - num2
res resb 2

section .text
global main

main:

; prompt first message
mov edx, len1
mov ecx, msg1
mov ebx, 1 
mov eax, 4
int 0x80

; input 1 
mov edx, 2 
mov ecx, num1
mov ebx, 0 
mov eax, 3 
int 0x80

; print num1
mov edx, len6
mov ecx, num1 
mov ebx, 1
mov eax, 4
int 0x80

; prompt second msg
mov edx, len2
mov ecx, msg2
mov ebx, 1 
mov eax, 4
int 0x80

; input 2
mov edx, 2 
mov ecx, num2
mov ebx, 0 
mov eax, 3 
int 0x80

; print num2
mov edx, len7
mov ecx, num2 
mov ebx, 1
mov eax, 4
int 0x80

; prompt for operation
mov edx, len3
mov ecx, msg3
mov ebx, 1 
mov eax, 4
int 0x80

; input operation
mov edx, 2 
mov ecx, res
mov ebx, 0 
mov eax, 3 
int 0x80

; print operation number
mov edx, 2
mov ecx, res
mov ebx, 1
mov eax, 4
int 0x80

; convert operation to integer
sub eax, [res]

; check operation choice
cmp byte [res], '1'
je addition
cmp byte [res], '2'
je subtraction
cmp byte [res], '3'
je multiplication
cmp byte [res], '4'
je division
jmp invalid_operation

addition:
; add num1 and num2
mov eax, [num1]
sub eax, '0' ; convert ASCII to decimal
mov ebx, [num2]
sub ebx, '0'
add eax, ebx
add eax, '0' ; convert decimal to ASCII
mov [res], eax
jmp print_result

subtraction:
; subtract num2 from num1
mov eax, [num1]
sub eax, '0' ; convert ASCII to decimal
mov ebx, [num2]
sub ebx, '0'
sub eax, ebx
add eax, '0' ; convert decimal to ASCII
mov [res], eax
jmp print_result

multiplication:
; multiply num1 and num2
mov eax, [num1]
sub eax, '0' ; convert ASCII to decimal
mov ebx, [num2]
sub ebx, '0'
imul eax, ebx
add eax, '0' ; convert decimal to ASCII
mov [res], eax
jmp print_result

division:
; divide num1 by num2
mov eax, [num1]
sub eax, '0' ; convert ASCII to decimal
mov ebx, [num2]
sub ebx, '0'
xor edx, edx ; Clear edx to prepare for the division
idiv ebx
add eax, '0' ; convert decimal to ASCII
mov [res], eax ; Store the quotient in the result
jmp print_result

print_result:
; type prompt for result
mov edx, len5
mov ecx, msg5
mov ebx, 1 
mov eax, 4
int 0x80

; print result
mov edx, 1
mov ecx, res
mov ebx, 1
mov eax, 4
int 0x80
jmp exit_program

invalid_operation:
; type prompt for invalid operation
mov edx, len4
mov ecx, msg4
mov ebx, 1 
mov eax, 4
int 0x80
jmp exit_program

exit_program:
; exit program
mov eax, 1
xor ebx, ebx
int 0x80