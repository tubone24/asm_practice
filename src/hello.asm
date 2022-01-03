global _start

section .data
message: db 'hello, world!', 10
msglen   equ  $ - message

section .text
_start:
    mov rax, 1          ; write syscall: 1
    mov rdi, 1          ; stdout: 1
    mov rsi, message    ; string address
    mov rdx, msglen     ; string length =14
    syscall             ; not use int 0x80 for 64bit

    mov rax, 60  ;exit syscall: 60
    xor rdi, rdi
    syscall