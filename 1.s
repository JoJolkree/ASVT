.globl _start	# entry point
.text		# code section
bulen	= 10000000
_start:
# 64-bit version

	xor	%eax, %eax
	mov	$3, %edi
	mov	$bubufer, %rsi
	mov	$bulen, %rdx
	syscall
	mov	%rax, %rdx
#
	mov	$1, %rax
	mov	$1, %rdi
	mov	$bubufer, %rsi
#	mov	$lmessg, %rdx
	syscall
	mov	$60, %rax
	syscall

# 32-bit version
#	mov	$4, %eax
#	mov	$1, %ebx
#	mov	$messg, %ecx
#	mov	$lmessg, %edx
#	int	$0x80
#	mov	$1, %eax
#	int	$0x80

.data
messg:	.ascii "Hello, ASVT\n"
lmessg	= . - messg	# . - адрес текущей метки

.bss
.lcomm	bubufer, bulen	# метка бубуфер размером в 10 МБ. Можем адресовать их по имени bubufer

# as -o 1.o 1.s
# ld -o 1 1.o

# ./1 3<filename
