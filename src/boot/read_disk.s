read_disk:
    pusha

    mov     ah,     0x02
    mov     ch,     0   ; cylinder 0
    mov     dh,     0   ; head 0

    int     0x13 
    jc      disk_error

    mov     bx,     disk_pass_string
    call    print_message__bios

    ; verify if read segment is actually read (call function)
    call    check_read_validity

    popa
    ret


disk_error:
    mov     bx,     disk_error_string
    call    print_message__bios
    jmp     $       ; loop in place after error
    
disk_error_string: 
    db "disk error", 0

disk_pass_string:
    db "disk load completed with no errors", 0

