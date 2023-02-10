section .data
	file_name: db "fib.bin", 0
	error: db "MENSAGEM DE ERRO", 10, 0
	errorL: equ $ - error

section .bss
	input: resb 3
	trash: resb 1

section .text
	global _start
	
_start:
	
	mov rax, 0
	mov rdi, 0
	mov rsi, input
	mov rdx, 3
	syscall

	cmp byte[input], 10
	je fim

	cmp byte[input + 1], 10
	je fib

	cmp byte[input + 2], 10
	je fib


	tratamento:
		mov rax, 0
		mov rdi, 0
		mov rsi, trash
		mov rdx, 1
		syscall

		cmp byte[trash], 10
		jne tratamento

		je fim

		

	fib:


	fim:

	erro:
		mov rax, 1
		mov rdi, 0
		mov rsi, error
		mov rdx, errorL
		syscall
		

	mov rax, 60
	syscall

	


