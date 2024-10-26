enter_a20:
    pusha

    in      al,     0x96    ; read from the a20 port
    or      al,     2       ; use or to flip the second last bit
    out     0x96,   al      ; return flipped bit to enable a20

    popa
    ret
