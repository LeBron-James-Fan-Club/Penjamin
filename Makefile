CC = clang-18 -target i686-unknown-unknown-elf
LD = /git/LeBron-James-Fan-Club/opt/bin/i686-elf-ld

final: build/os.bin

.PHONY: clean
clean:
	rm -rf build/

build/assembly.o: src/boot/bootloader.s
	mkdir -p build/
	nasm src/boot/bootloader.s -f elf -o build/assembly.o

build/kernel.o: src/kernel/kernel_main.c
	mkdir -p build/
	$(CC) -c src/kernel/kernel_main.c -o build/kernel.o

build/os.bin: build/assembly.o build/kernel.o src/linker.ld
	$(LD) -o build/os.bin -T src/linker.ld build/kernel.o build/assembly.o --oformat binary

run: build/os.bin
	qemu-system-x86_64 -fda build/os.bin
