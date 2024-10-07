; the boot process:
    ; the basic bios boot process is:
    ; check for the 512th byte after 0x7c00
    ; if it is 0xAA55 then jump to 0x7c00 to start executing
    ; otherwise, keep checking other drive devices

; i think this is a nasm thing since org and bits are preprocessor macros
; making sure our code starts at 0x7c00
org 0x7c00
bits 16

jmp     print_boot_message__init

; bios syscalls to print
print_boot_message__init:
    lea     bx,     message_on_boot
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
    jmp     print_boot_message__end

message_on_boot:
    db "sigma sigma", 0

; populates the bootloader to be exactly 510 bytes after 0x7c00
; so we can set the 511th and 512th bytes to be 0xAA55
    ; $ is the address of the current line, $$ is the address of the current section
    ; doing this lets us fill in the rest of the program with 0s so we can position
    ; 0xAA55 at 511-512
times 510 - ($ - $$) db 0
; used to show that this device is bootable to the bios
dw      0xAA55
