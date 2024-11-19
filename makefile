final: build/bootloader build/kernel.bin build/os-image.bin

build/bootloader: src/boot/bootloader.s src/boot/print_bios.s src/boot/read_disk.s
	nasm src/boot/bootloader.s -f bin -o build/bootloader.bin

build/kernel.bin: src/kernel/kernel_main.c 
	i686-elf-gcc -ffreestanding -c src/kernel/kernel_main.c -o build/kernel.o
	nasm src/boot/kernel_entry.s -f elf -o build/kernel_entry.o
	i686-elf-ld -o build/kernel.bin -Ttext 0x1000 build/kernel_entry.o build/kernel.o --oformat binary

build/os-image.bin: build/bootloader.bin build/kernel.bin
	cat build/bootloader.bin build/kernel.bin > build/os-image.bin

run: final
	qemu-system-x86_64 -fda build/os-image.bin
