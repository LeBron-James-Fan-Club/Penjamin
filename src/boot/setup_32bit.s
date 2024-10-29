enter_a20:
    pusha

    in      al,     0x96    ; read from the a20 port
    or      al,     2       ; use or to flip the second last bit
    out     0x96,   al      ; return flipped bit to enable a20

    popa
    ret

setup_vga:
    mov     ax,     0x3
    int     0x10

enter_gdt:
    pusha

    cli
    lgdt    [gdt__descriptor]

    mov     eax,    cr0
    or      eax,    1
    mov     cr0,    eax
    popa
    ret

    ; gdt parameters:
    ; base              - where the segment starts
    ; limit             - how big the segment is
    ; present           - 1 if the segment is present in memory
    ; privilige         - 0, 1, 2, 3; ring 0 determines the privilge level
    ; descriptor-type   - 1 for code segment, 0 for data segmetn
    ; type:
    ;   code            - code or data segment
    ;   conforming      - if set to 0, code in a segmetn with lower privilege can't call
    ;                     code in this segment (i.e. memory protection)
    ;   readable        - allows to read constants in code
    ;   accessed        - mostly used for debugging/vram techniques (cpu sets to 1 when
    ;                     it accesses the segment)
gdt__start:
gdt__null:
    dq      0x0
gdt__code:
    dw      0xffff      ; limit
    dw      0x0         ; base (bits 0-15)
    db      0x0         ; base (bits 16-23)
    db      10011010b   ; 1st flags , type flags
    db      11001111b   ; 2nd flags , Limit ( bits 16 -19)
    db      0x0         ; base (bits 24-31)

gdt__data:
    dw      0xffff      ; limit
    dw      0x0         ; base (bits 0-15)
    db      0x0         ; base (bits 16-23)
    db      10010010b   ; 1st flags , type flags
    db      11001111b   ; 2nd flags , Limit ( bits 16 -19)
    db      0x0         ; base (bits 24-31)
gdt__end:

gdt__descriptor:
    dw      gdt__end - gdt__start - 1   ; gets the size of our gdt
    dd      gdt__start                  ; beginning address of our gdt

CODE_SEG    equ gdt__code - gdt__start
DATA_SEG    equ gdt__data - gdt__start
