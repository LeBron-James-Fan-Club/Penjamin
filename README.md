# Penjamin ✍️ ✍️🔥🔥

Penjamin is a hobbist x86 operating system built to be booted from a pen drive (since its cool to show people that the operating system u wrote as a physical token)

![image](https://github.com/user-attachments/assets/84cb15d7-7371-4842-88e4-07a4b42d2504)

## architecture
- Two-stage bootloader

## TODOS
- [ ] bios bootloader (switch to UEFI after OS is stable)
  - [x] Setup skeleton (start at 0x7c00, show bios signature at bytes 511 & 512)
  - [x] A20 line
  - [ ] GDT & GDTR
  - [ ] 32 bit mode
  - [ ] preparing to boot (gathering info)
- [ ] kernel
