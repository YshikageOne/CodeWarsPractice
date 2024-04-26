section .text
extern io_get_dec, io_print_dec, io_newline
global main

main:
    mov ebp, esp ; for correct debugging

    ; Read first number
    call io_get_dec
    mov ebx, eax ; store first number in ebx
    call io_print_dec ; Debug: Print first number
    call io_newline

    ; Read second number
    call io_get_dec
    mov ecx, eax ; store second number in ecx
    call io_print_dec ; Debug: Print second number
    call io_newline

    ; Read operation code
    call io_get_dec
    mov edx, eax ; store operation code in edx
    call io_print_dec ; Debug: Print operation code
    call io_newline

    ; Perform operation based on the operation code
    cmp edx, 1
    je perform_add
    cmp edx, 2
    je perform_sub
    cmp edx, 3
    je perform_mul
    cmp edx, 4
    je perform_div

    ; Default case: handle invalid operation
    jmp invalid_operation

perform_add:
    call io_print_dec  ; Debug: Print "1" for add
    add ebx, ecx
    jmp print_result

perform_sub:
    call io_print_dec  ; Debug: Print "2" for sub
    sub ebx, ecx
    jmp print_result

perform_mul:
    call io_print_dec  ; Debug: Print "3" for mul
    mul ebx
    jmp print_result

perform_div:
    call io_print_dec  ; Debug: Print "4" for div
    ; Check for division by zero
    test ecx, ecx
    jz error_division
    mov eax, ebx
    cdq
    div ecx
    mov ebx, eax
    jmp print_result

error_division:
    mov ebx, -1 ; Indicate error
    jmp print_result

invalid_operation:
    mov ebx, 0 ; Indicate invalid operation

print_result:
    ; Print result
    mov eax, ebx  ; Ensure the result is in eax for printing
    call io_print_dec
    call io_newline

    ; Exit
    xor eax, eax
    ret