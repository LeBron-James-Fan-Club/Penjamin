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

    ;
    mov     bx,     0x7e00
    call    read_disk
    
    call    enter_a20
    jmp $



    

%include "src/boot/print.s"
%include "src/boot/read_disk.s"
%include "src/boot/setup_32bit.s"

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

check_read_validity:
    pusha

    mov     bx,     "x"
    call    print_hex_char_bios
    ; reset cursor to beginning of line and then newline
    mov     bx,     13
    call    print_hex_char_bios
    mov     bx,     10
    call    print_hex_char_bios

    popa
    ret
