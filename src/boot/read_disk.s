read_disk:
    pusha

    mov     ah,     0x02
    mov     al,     1   ; read 1 sectors
    mov     ch,     0   ; cylinder 0
    mov     cl,     2   ; read from the second sector
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
    pusha
    mov     bx,     disk_error_string
    call    print_message__bios
    popa
    jmp     $       ; loop in place after error
    
disk_error_string: 
    db "disk error", 0

disk_pass_string:
    db "disk load completed with no errors", 0

