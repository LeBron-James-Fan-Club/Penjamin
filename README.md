# Penjamin ✍️ ✍️🔥🔥

Penjamin is a hobbist x86 operating system built to be booted from a pen drive (since its cool to show people that the operating system u wrote as a physical token)

![image](https://github.com/user-attachments/assets/84cb15d7-7371-4842-88e4-07a4b42d2504)

## architecture
- Two-stage bootloader

## TODOS
- [ ] write good docs :(
- [ ] bios bootloader (switch to UEFI after OS is stable)
  - [x] Setup skeleton (start at 0x7c00, show bios signature at bytes 511 & 512)
  - [x] A20 line
  - [ ] GDT & GDTR
  - [ ] 32 bit mode
  - [ ] preparing to boot (gathering info)
- [ ] kernel

## Resources
[prolly the best resource you can ever use](https://youtube.com/playlist?list=PL5p37LtXzjqOoEl369i0nlTSaU1O3L-BN&si=4w42QHoUpCoiOeS1)

[bootloader stuff](http://www.cs.cmu.edu/~410-s07/p4/p4-boot.pdf)

### link dump
https://www.cs.bham.ac.uk//~exr/lectures/opsys/10_11/lectures/os-dev.pdf

https://littleosbook.github.io/

https://github.com/cfenollosa/os-tutorial

https://en.wikibooks.org/wiki/X86_Assembly/Bootloaders


