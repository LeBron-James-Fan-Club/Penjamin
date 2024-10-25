final: build/bootloader

build/bootloader: src/boot/bootloader.s
	nasm src/boot/bootloader.s -o build/bootloader

run: build/bootloader
	qemu-system-x86_64 build/bootloader
