section	.text
    global  _start
_start:
	mov rcx, 1                       	; loop cnt (incremental)

	loop_main:
	push rcx                       	    ; loop cnt to stack

	; divisible by 3 and 5 (15)
	xor rdx, rdx                       	; reset rdx
	mov rax, rcx
	mov rbx, 15
	div rbx                             ; div rbx: rax / rbx = rax % rdx
	cmp rdx, 0                          ; If rdx equal 0,
	jz print_fizzbuzz                    ; jz: jump if zero to print_fizzbuzz

    ; divisible by 3
	xor rdx, rdx                       	; reset dx
	mov rax, rcx
	mov rbx, 3
	div rbx
	cmp rdx, 0
	jz print_fizz

    ; divisible by 5
	xor rdx, rdx                       	; reset dx
	mov rax, rcx
	mov rbx, 5
	div rbx
	cmp rdx, 0
	jz print_buzz

 	; print number
	mov rax, rcx                     	; register the registers required to execute print_num_ascii.
	call print_num_ascii
	jmp inc_cnt

	print_fizzbuzz:                      ; print FizzBuzz
	mov rax, 1                       	; syscall write is `1` in Linux x86_64  refs: https://www.mztn.org/lxasm64/x86_x64_table.html
	mov rdi, 1                       	; 1: stdout
	mov rsi, fizzbuzz                	; ptr to buffer `FizzBuzz`
	mov rdx, fizzbuzzlen                 ; buffer size
	syscall                             ; syscall
	jmp inc_cnt                         ; increment loop cnt

	print_fizz:                        	; print Fizz
	mov rax, 1 
	mov rdi, 1
	mov rsi, fizz
	mov rdx, fizzlen
	syscall
	jmp inc_cnt

	print_buzz:
	mov rax, 1
	mov rdi, 1 
	mov rsi, buzz
	mov rdx, buzzlen
	syscall
	jmp inc_cnt

	inc_cnt:
	pop rcx  				           ; restore loop counter
	cmp rcx, 100
	jz exit                          	; end of loop
	inc rcx                          	; increment loop counter
	jmp loop_main

	exit:
	mov rax, 60                         ; syscall exit is 60
	xor rdi, rdi                     	; exit(0)
	syscall

print_num_ascii:                        ; rax: the number you want to print
	push rsi                         	; push counter on stack
	mov rsi, 0                       	; set digit length counter to 0

	loop_div_all_digit:                 ; dividing until rax is 0
	mov rdx, 0
	mov rbx, 10
	div rbx
	add rdx, 48                      	; ascii char `0` is 0x30 (48); convert number to ascii char
	push rdx                         	; push char on stack
	inc rsi                          	; increment digit length counter
	cmp rax, 0
	je print_stack                   	; rax is 0, break
	jmp loop_div_all_digit

	print_stack:                     	; print chars on stack
	cmp rsi, 0
	je done                          	; digit length counter is 0; nothing left to print
	dec rsi                          	; decrement digit length counter
	mov r8, rsi                         ; escape rsi number because of syscall
	xor rsi, rsi                        ; reset rsi
	mov rax, 1                       	; syscall write: 1
	mov rdi, 1                       	; stdout: 1
	mov rdx, 1                       	; length: 1
	mov rsi, rsp                     	; syscall write arg set top of stack
	syscall
	add rsp, 8                       	; update stack ptr to next stack (maybe pop is also ok)
	mov rsi, r8                         ; back to escaped rsi
	jmp print_stack

	done:
 	; print new line(\n)
	mov rax, 1
	mov rdi, 1
	mov rsi, nl
	mov rdx, 1
	syscall
	pop rsi
	ret

section .data
	fizz: db 'Fizz', 10
	fizzlen   equ  $ - fizz
	buzz: db 'Buzz', 10
	buzzlen   equ  $ - buzz
	fizzbuzz: db 'FizzBuzz', 10
	fizzbuzzlen   equ  $ - fizzbuzz
	nl dw 0xa
section .bss