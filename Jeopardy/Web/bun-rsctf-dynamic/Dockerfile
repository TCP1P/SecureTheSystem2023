FROM oven/bun:latest as base
WORKDIR /app

FROM base as install
COPY ./src/package.json .
RUN bun install

FROM base as release
RUN apt update -y
RUN apt install -y wget

COPY ./flag.txt /flag.txt
RUN mv /flag.txt /flag_`cat /proc/sys/kernel/random/uuid`.txt

WORKDIR /app
COPY --from=install --chown=ctf:ctf /app .

COPY ./src .

EXPOSE 8080
CMD ["bash", "-c", "Hacker_Token=`cat /dev/urandom | head -c 32 | base64` bun run index.tsx"]

# RSCTF dynamic-flag compatibility layer. The build-time scan records
# exact marker-bearing files; runtime replacement is therefore bounded
# to those files instead of walking the image on every team start.
USER root
COPY rsctf-entrypoint.sh /usr/local/bin/rsctf-entrypoint
RUN set -eu; \
    chmod 0555 /usr/local/bin/rsctf-entrypoint; \
    : > /etc/rsctf-flag-targets; \
    for root in /app /src /srv /home /opt /var/www /challenge /chall /ctf /root /usr/src /usr/local/bin /workspace /flag /flag.txt; do \
      if [ -e "$root" ]; then \
        find "$root" -xdev -type f ! -path /usr/local/bin/rsctf-entrypoint -exec grep -lF -e RSCTF_DYNAMIC_FLAG_af351cd6b56c3badf058d6dc320f554fbad580339511ba4f88 -e RSCTF_DYNAMIC_FLAG_4ca4a1d1b8497cbd874a37b7dd33d91b55fdfc6e2eb {} + >> /etc/rsctf-flag-targets 2>/dev/null || true; \
      fi; \
    done; \
    sort -u /etc/rsctf-flag-targets > /etc/rsctf-flag-targets.sorted; \
    mv /etc/rsctf-flag-targets.sorted /etc/rsctf-flag-targets; \
    while IFS= read -r target; do [ -f "$target" ] && chmod a+w "$target"; done < /etc/rsctf-flag-targets
ENTRYPOINT ["/usr/local/bin/rsctf-entrypoint"]
