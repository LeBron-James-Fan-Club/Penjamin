; the boot process:
    ; the basic bios boot process is:
    ; check for the 512th byte after 0x7c00
    ; if it is 0xAA55 then jump to 0x7c00 to start executing
    ; otherwise, keep checking other drive devices

; i think this is a nasm thing since org and bits are preprocessor macros
; making sure our code starts at 0x7c00
[org 0x7c00]
[bits 16]

; setup stack
    mov     bp,     0x7c00
    mov     sp,     bp

start:
    mov     bx,     message_on_boot
    call    print_message__bios

    ; tell bios interrupt that we want to load read disk values into memory addresses of
    ; ES:BX = 0:0x7e00
    mov     bx,     0x7e00
    call    read_disk
    
    jmp     continue_main


%include "src/boot/print_bios.s"
%include "src/boot/read_disk.s"

message_on_boot:
    db 10, "Sigma rule #1:", 13, 10, "if your tummy hurts, try not to cry.", 13, 10, 0

; populates the bootloader to be exactly 510 bytes after 0x7c00
; so we can set the 511th and 512th bytes to be 0xAA55
    ; $ is the address of the current line, $$ is the address of the current section
    ; doing this lets us fill in the rest of the program with 0s so we can position
    ; 0xAA55 at 511-512
times 510 - ($ - $$) db 0
; used to show that this device is bootable to the bios
dw      0xAA55

; second sector starts here
check_read_validity:
    pusha

    mov     bx,     disk_read_successful_string
    call    print_message__bios

    popa
    ret

continue_main:
    call    enter_a20
    call    setup_vga

    call    enter_gdt

    ; finally enter 32 bit protected mode
    jmp     CODE_SEG:enter_protected_mode


[bits 32]
enter_protected_mode:
    mov     ax,     DATA_SEG    ; our old segments are useless,
    mov     ds,     ax ; so we point our segment registers to the
    mov     ss,     ax ; data selector we defined in our GDT
    mov     es,     ax
    mov     fs,     ax
    mov     gs,     ax

    mov     ebp,    0x90000
    mov     esp,    ebp

    jmp $

%include "src/boot/setup_32bit.s"
%include "src/boot/print_vga.s"

disk_read_successful_string:
    db "disk read successful!", 0, 0
gdt_success_string:
    db "successfully entered 32 bit + gdt!", 0, 0

