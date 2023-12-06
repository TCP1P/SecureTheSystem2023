import struct

def flip(n, i=0):
    state = list(bin(n)[2:].zfill(32))
    for i in reversed(range(i, len(state))):
        if state[i] == '0':
            state[i] = '1'
        else:
            state[i] = '0'
    return int(''.join(state), 2)

def rotate(n):
    state = ((n << 24) | (n >> 8)) & 0xFFFFFFFF
    return state

def reverse(n):
    state = list(bin(n)[2:].zfill(32))
    state.reverse()
    return int(''.join(state), 2)

enc = b'5\xd55\xb0\xb9!3hQ\x19\x89\x88I\x05\x19h\xb1i)hi\x05\x89\xd8\xb1\x05YXy\x05\x91\xf0y\xc9y\x181\x05iXiy\xc9\x88\xc9\x99\x05XY9\x19(\x05\xb1Y\x10)\x11)@\x00\x00\x00\x00'

enc = [struct.unpack("<L", enc[i:i+4])[0] for i in range(0, len(enc), 4)]
dec = []

dec.append(struct.pack("<L", flip(rotate(reverse(enc[0])), i=2)))

for i in range(1,15):
    dec.append(struct.pack("<L", flip(rotate(reverse(enc[i])), i=1)))

print(b''.join(dec).decode())