.globl _start
.text
_start:
    jmp _main
    # open img file for rw
    # mov $2, %rax
	# pop %rdi
    # mov $2, %rsi
    # syscall
    # mov $img_file_descriptor, %rbx
    # mov %rax, img_file_descriptor

    # open asm file for read
    # mov $2, %rax
    # pop %rdi
    # xor %rsi, %rsi
    # syscall
    # mov $asm_file_descriptor, %rbx
    # mov %rax, asm_file_descriptor
    _help:
        mov $1, %rax
        mov $1, %rdi
        mov $help_string, %rsi
        mov $help_string_len, %rdx
        syscall
        jmp _exit
    
    _img_not_found:
        mov $1, %rax
        mov $1, %rdi
        mov $img_not_found_str, %rsi
        mov $img_not_found_str_len, %rdx
        syscall
        jmp _exit

    _asm_not_found:
        mov $1, %rax
        mov $1, %rdi
        mov $img_not_found_str, %rsi
        mov $img_not_found_str_len, %rdx
        syscall
        jmp _exit

    _main:
        pop %rax
        cmp $5, %rax
        jne _help
        pop %rax

        _open_files:
            mov $2, %rax
            pop %rdi
            mov $2, %rsi        
            syscall
            cmp $-2, %rax
            je  _img_not_found
            mov $img_file_descriptor, %rbx        
            mov %rax, (%rbx)

            mov $2, %rax
            pop %rdi
            xor %rsi, %rsi        
            syscall
            cmp $-2, %rax
            je  _img_not_found
            mov $img_file_descriptor, %rbx        
            mov %rax, (%rbx)

        _parse_track_number: # доделать это говно
            pop %rbx
            mov (%rbx), %rax
            add $30, %rax
            mov 8(%rbx), %rcx
            cmp $0, %rcx
            je _write_filename
            mov $10, %rdx
            mul %rdx
            add $30, %rcx
            add %rcx, %rax
        
        _write_filename:
            

    _exit:
        mov $60, %rax
        syscall

.data
#    img_file_descriptor dq  0
#    asm_file_descriptor dq  0
help_string:    .ascii "It's a help string\n"
help_string_len = . - help_string

img_not_found_str:  .ascii "img not found\n"
img_not_found_str_len = . - img_not_found_str

asm_not_found_str:  .ascii "asm not found\n"
asm_not_found_str_len = . - asm_not_found_str

img_file_descriptor:    .quad   0
asm_file_descriptor:    .quad   0
track_number:   .quad    0
