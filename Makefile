CFLAGS = -static -fno-builtin -fno-strict-aliasing -O0 -Wall -MD -ggdb -m32 -Werror -fno-omit-frame-pointer -fno-stack-protector -no-pie -fno-stack-protector

xv6.img: bootblock
	dd if=/dev/zero of=xv6.img count=10000
	dd if=bootblock of=xv6.img conv=notrunc

bootblock: bootasm.S
	gcc $(CFLAGS) -fno-pic -O -nostdinc -I. -c bootasm.S
	ld -m elf_i386 -N -e start -Ttext 0x7c00 -o bootblock.o bootasm.o
	objdump -S bootblock.o > bootblock.asm  # 必須ではない
	objcopy -S -O binary -j .text bootblock.o bootblock
	./sign.pl bootblock

qemu: xv6.img
	qemu-system-i386 -drive file=xv6.img,index=0,media=disk,format=raw -smp 2 -m 512
