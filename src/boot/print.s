; bios syscalls to print
print_boot_message__init:
print_boot_message__cond:
    mov     cx,     [bx]
    cmp     cx,     0
    je      print_boot_message__end

print_boot_message__body:
    ; kinda hacky ngl (cx = ch (top 8 bits) + cl (low 8 bits))
    mov     al,     cl
    mov     ah,     0xe
    int     0x10

    add     bx,     1
    jmp     print_boot_message__cond
print_boot_message__end:
    ret
