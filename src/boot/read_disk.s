read_disk:
    ; AH = 02
    ; AL = number of sectors to read	(1-128 dec.)
    ; CH = track/cylinder number  (0-1023 dec., see below)
    ; CL = sector number  (1-17 dec.)
    ; DH = head number  (0-15 dec.)
    ; DL = drive number (0=A:, 1=2nd floppy, 80h=drive 0, 81h=drive 1)
    ; ES:BX = pointer to buffer

    ; on return:
    ; AH = status  (see INT 13,STATUS)
    ; AL = number of sectors read
    ; CF = 0 if successful
    ;    = 1 if error

    pusha

    mov     ah,     0x02
    mov     al,     1   ; read 2 sectors
    mov     ch,     0   ; cylinder 3
    mov     cl,     2
    mov     dh,     0

    mov     di,     0x8000


    int     0x13 
    jc      disk_error

    mov     bx,     disk_pass_string
    call    print_message__init

    popa
    ret

disk_error:
    pusha
    mov     bx,     disk_error_string
    call    print_message__init
    popa
    jmp     $       ; loop in place after error
    
disk_error_string: 
    db "disk error", 10, 0

disk_pass_string:
    db "disk load passed", 10, 0
