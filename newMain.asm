; nasm -f elf64 a07e01b.asm ; ld a07e01b.o -o a07e01b.x

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
	je erro

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

		je fib

	; trat1:
	; 	mov r12, [input]
	; 	; add r12, -48
	
	; trat2:

		

	fib:
		cmp eax, 3
		mov al, [input]
		add al, -48
		je _multiplique3
		jne _multiplique2

		_multiplique3:
		jmp fim

		_multiplique2:
		; mov eax, 0
		jmp fim
	fim:

	
		

	mov rax, 60
	syscall


	erro:
		mov rax, 1
		mov rdi, 0
		mov rsi, error
		mov rdx, errorL
		syscall
		jmp fim