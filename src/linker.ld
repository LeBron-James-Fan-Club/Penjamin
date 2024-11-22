OUTPUT_FORMAT(binary)

SECTIONS
{
    .bootmain 0x0000 : {
        KEEP(*(.bootmain))
    }

    . = 0x1000;
    .text : {
        *(.text)
        KEEP(*(.kernel_main))
    }

    .rodata : {
        *(.rodata)
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(COMMON)
        *(.bss)
    }
}
