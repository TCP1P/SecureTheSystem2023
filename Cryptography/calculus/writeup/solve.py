from libnum import n2s

x,z,enc = open('output.txt', 'r').readlines()
x = int(x.strip())
z = int(z.strip())
enc = int(enc.strip(), 16)

y = pow(x,2) - 2*(z-1)
enc = enc // (x + y)
flag = enc ^ int((3*x*y- x**3)//2)
flag = n2s(flag)
print(flag.decode())