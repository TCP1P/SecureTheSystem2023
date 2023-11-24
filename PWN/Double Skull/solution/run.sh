#!/bin/bash
gcc -static -o exploit exploit.c; mv exploit fs
cd fs; find . | cpio -H newc -o | gzip > ../initramfs.cpio.gz; cd ..;
tmux splitw -h "gdb ./vmlinux -x gdb.sh"

/usr/bin/qemu-system-x86_64 \
        -m 64M \
        -cpu kvm64,+smep,+smap \
        -nographic \
        -monitor /dev/null \
        -kernel bzImage \
        -initrd initramfs.cpio.gz \
	--no-reboot \
	-append "console=ttyS0 quiet kaslr panic=1 kpti=1 oops=panic" \
	-s
