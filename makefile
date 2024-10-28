final: build/bootloader

build/bootloader: src/boot/bootloader.s src/boot/print_bios.s src/boot/read_disk.s
	nasm src/boot/bootloader.s -o build/bootloader

run: final
	qemu-system-x86_64 -fda build/bootloader
