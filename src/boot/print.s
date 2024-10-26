; bios syscalls to print
print_message__init:
    pusha
print_message__cond:
    mov     cx,     [bx]
    cmp     cx,     0
    je      print_message__end

print_message__body:
    ; kinda hacky ngl (cx = ch (top 8 bits) + cl (low 8 bits))
    mov     al,     cl
    mov     ah,     0xe
    int     0x10

    add     bx,     1
    jmp     print_message__cond
print_message__end:
    popa
    ret

print_hex_char:
    pusha

    mov     al,     bl
    mov     ah,     0x0e
    int     0x10

    popa
    ret
