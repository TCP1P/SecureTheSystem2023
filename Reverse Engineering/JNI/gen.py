import random 

charset = "tYAGCU{Dd1lPQ7qS4Mev5np0sfzFaZmwXBTKcNiHVRxr6_2}ogkIJ8hWuybL3E9jO"
flag = "STS23{capek_gak_sih_tiap_ketemu_gw_selalu_reversing_apk_kawokoawowa}"
keys = []

indices = []
for i in range(len(flag)):
    keys.append(random.randint(1, 255))
    indices.append(charset.index(flag[i]) ^ keys[i])

print(indices)
print(keys)