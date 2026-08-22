#!/bin/sh
set -eu
python3 - <<'PY'
import gzip
import os
from pathlib import Path
archive = Path('/home/ctf/initramfs.cpio.gz')
archived = bytes.fromhex('53545332337b64616d6e5f62726f5f696d6167696e655f67657474696e675f70776e65645f7477696365f09f98a5f09f98a27d')
current = os.environ['RSCTF_FLAG'].encode()
if len(current) != len(archived):
    raise SystemExit('RSCTF flag length does not match the archived initramfs slot')
raw = gzip.decompress(archive.read_bytes())
if archived in raw:
    raw = raw.replace(archived, current)
elif current not in raw:
    raise SystemExit('archived initramfs flag slot was not found')
temporary = archive.with_name(archive.name + '.rsctf')
temporary.write_bytes(gzip.compress(raw, compresslevel=9, mtime=0))
temporary.replace(archive)
PY
