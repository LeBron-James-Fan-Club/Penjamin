[bits 32]

global _START

export kernel_main

_START:
    call kernel_main
    jmp $

times 512 - ($ - $$) db 0
