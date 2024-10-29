[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print__vga_init:
    pusha
    mov     edx,    VIDEO_MEMORY
print__vga_cond:
    mov     al,     [ebx]
    cmp     al,     0
    je      print__vga_end

print__vga_body:
    mov     ah,     WHITE_ON_BLACK

    mov     [edx], ax   ; store char + value into char cell

    add     ebx,    1
    add     edx,    2
    jmp     print__vga_cond
print__vga_end:
    popa
    ret

