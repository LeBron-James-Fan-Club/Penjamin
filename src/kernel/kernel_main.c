void kernel_main() __attribute__((section(".kernel_main")));

static _Noreturn void die() {
    while (1);
}

void kernel_main() {
    volatile char *video_memory = (volatile char *) 0xb8000;
    *video_memory = 'X';

    die();
}
