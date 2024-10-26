final: build/bootloader

build/bootloader: src/boot/bootloader.s src/boot/print.s src/boot/read_disk.s
	nasm src/boot/bootloader.s -o build/bootloader

run: build/bootloader
	nasm src/boot/bootloader.s -o build/bootloader
	qemu-system-x86_64 -fda build/bootloader
