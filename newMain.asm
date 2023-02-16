; nasm -f elf64 a07e01b.asm ; ld a07e01b.o -o a07e01b.x

section .data
	filename: db "fib(", 0
	filename2: db ").bin", 0
	error: db "MENSAGEM DE ERRO", 10, 0
	errorL: equ $ - error
	errorR: db "Registrador Estourado", 10, 0
	errorRL: equ $ - errorR
	fib: dq 0

section .bss
	input: resb 3
	trash: resb 1
	intFib: resq 1
	finalFile: resb 30
	
section .text
	global _start
	
_start:
	; ler o input para cálculo de Fib
	mov rax, 0
	mov rdi, 0
	lea rsi, [input]
	mov rdx, 3
	syscall
	
	; realiza comparação /n
	cmp byte[input], 10
	je erro

	cmp byte[input + 1], 10
	je fib1

	cmp byte[input + 2], 10
	je fib2
	jne tratamento


	fib1:
		mov al, [input]
		mov rbx, [filename]
		mov [finalFile], rbx
		mov [finalFile+4], al
		mov rbx, [filename2]
		mov [finalFile+5], rbx
		mov bl, [filename2+4]
		mov [finalFile+9], bl
		sub al, 48
		mov [intFib], al

		cmp al, 0
		je writeFile
		cmp al, 1
		je calcFib1
		mov r15, 1
		mov r14, 0
		jmp fibonacci
	
	fib2:
		mov cl, [input+1]
        mov al, [input]
        mov rbx, [filename]
        mov [finalFile], rbx
        mov [finalFile+4], al
        mov [finalFile+5], cl
        mov rbx, [filename2]
        mov [finalFile+6],rbx
        mov bl, [filename2+4]
        mov [finalFile+10], bl
        sub al, 48
        sub cl, 48
        imul ax, 10
        add al, cl
        mov [intFib], al
        cmp al, 94
        jge erroRegister
        mov r15, 1

	fibonacci:
		mov r13, r15
        add r15, r14
        mov [fib], r15
        mov r14, r13
        dec qword[intFib]
        cmp qword[intFib], 1
        jne fibonacci

        jmp writeFile


calcFib1:
	mov qword[fib], 1


writeFile:
	mov rax, 2
	lea rdi, [finalFile]
	mov edx, 664o
	mov esi, 102o
	syscall

	mov r9, rax
	mov rax, 1
	mov rdi, r9
	mov rsi, fib
	mov rdx, 8
	syscall

	mov rax, 3
	mov rdi, r9
	syscall
	jmp fim
	
tratamento:
	mov rax, 0
	mov rdi, 0
	mov rsi, [trash]
	mov rdx, 1
	syscall

	cmp byte[trash], 10
	jne tratamento



erro:
	mov rax, 1
	mov rdi, 1
	mov rsi, error
	mov rdx, errorL
	syscall

erroRegister:
	mov rax, 1
	mov rdi, 1
	mov rsi, errorR
	mov rdx, errorRL
	syscall

fim:
	mov rax, 60
	mov rdi, 0
	syscall


	