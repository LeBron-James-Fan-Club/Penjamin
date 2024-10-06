ASM = nasm

src/bootloader.s: build/bootloader
	nasm src/bootloader.s -o build/bootloader

run:
	qemu-system-x86_64 build/bootloader
