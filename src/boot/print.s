; bios syscalls to print
print_message__bios:
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
    mov     al,     13
    mov     ah,     0xe
    int     0x10

    mov     al,     10
    mov     ah,     0xe
    int     0x10

    popa
    ret

print_hex_char_bios:
    pusha

    mov     al,     bl
    mov     ah,     0x0e
    int     0x10

    popa
    ret
