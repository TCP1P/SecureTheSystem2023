#!/bin/sh
set -eu
: "${RSCTF_FLAG:?RSCTF_FLAG is required}"
export FLAG="$RSCTF_FLAG" APPFLAG="$RSCTF_FLAG" CTF_FLAG="$RSCTF_FLAG" GZCTF_FLAG="$RSCTF_FLAG" APPSEED="$RSCTF_FLAG"
export FLAG_FILE="${RSCTF_FLAG_FILE:-/flag}" GZCTF_FLAG_FILE="${RSCTF_FLAG_FILE:-/flag}"
marker=RSCTF_DYNAMIC_FLAG_af351cd6b56c3badf058d6dc320f554fbad580339511ba4f88
payload_marker=RSCTF_DYNAMIC_FLAG_4ca4a1d1b8497cbd874a37b7dd33d91b55fdfc6e2eb
rsctf_payload=${RSCTF_FLAG#*\{}
rsctf_payload=${rsctf_payload%\}}
if [ -f /etc/rsctf-flag-targets ]; then
  while IFS= read -r target; do
    [ -f "$target" ] || continue
    temporary=${TMPDIR:-/tmp}/rsctf-flag.$$
    sed -e "s|${marker}|${RSCTF_FLAG}|g" -e "s|${payload_marker}|${rsctf_payload}|g" "$target" > "$temporary"
    cat "$temporary" > "$target"
    rm -f "$temporary"
  done < /etc/rsctf-flag-targets
fi
if [ -x /usr/local/bin/rsctf-prepare-flag ]; then /usr/local/bin/rsctf-prepare-flag; fi
[ "$#" -gt 0 ] || { echo 'RSCTF runtime has no command' >&2; exit 1; }
exec "$@"
