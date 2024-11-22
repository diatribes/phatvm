bits 64

global _start 

_start:
    mov rax, 173        ; ioperm syscall number
    mov rdi, 0x604      ; port address
    mov rsi, 16         ; num bits
    mov rdx, 1          ; on/off
    syscall

    mov dx, 0x604       ; port address
    mov eax, 0x2000     ; shutdown bits
    out dx, eax         ; write to port

    mov rax, 60         ; exit syscall number
    mov rdi, 0          ; return code
    syscall

