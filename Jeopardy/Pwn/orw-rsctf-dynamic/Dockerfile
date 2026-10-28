FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends socat \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --system ctf \
    && useradd --system --gid ctf --home-dir /home/ctf --no-create-home ctf \
    && mkdir -p /home/ctf

COPY challenge/orw /home/ctf/chall
RUN printf '%s\n' 'RSCTF_DYNAMIC_FLAG_b3f01fa8a710e72353886513cf7b47f305682de4c04' > /home/ctf/flag.txt \
    && chown -R root:ctf /home/ctf \
    && chmod 0550 /home/ctf/chall \
    && chmod 0440 /home/ctf/flag.txt

WORKDIR /home/ctf
EXPOSE 11337
CMD ["socat", "TCP-LISTEN:11337,reuseaddr,fork", "EXEC:/home/ctf/chall,su=ctf"]

USER root
COPY rsctf-entrypoint.sh /usr/local/bin/rsctf-entrypoint
RUN set -eu; \
    chmod 0555 /usr/local/bin/rsctf-entrypoint; \
    : > /etc/rsctf-flag-targets; \
    for root in /home/ctf/chall /home/ctf /app /src /srv /home /opt /var/www /challenge /chall /ctf /root /usr/src /usr/local/bin /workspace /flag /flag.txt; do \
      if [ -e "$root" ]; then \
        find "$root" -xdev -type f ! -path /usr/local/bin/rsctf-entrypoint -exec grep -lF -e RSCTF_DYNAMIC_FLAG_b3f01fa8a710e72353886513cf7b47f305682de4c04 -e RSCTF_DYNAMIC_FLAG_1d25374fd9fb080955a38a4b83db00de9caf {} + >> /etc/rsctf-flag-targets 2>/dev/null || true; \
      fi; \
    done; \
    sort -u /etc/rsctf-flag-targets > /etc/rsctf-flag-targets.sorted; \
    mv /etc/rsctf-flag-targets.sorted /etc/rsctf-flag-targets; \
    while IFS= read -r target; do [ -f "$target" ] && chmod a+w "$target"; done < /etc/rsctf-flag-targets
ENTRYPOINT ["/usr/local/bin/rsctf-entrypoint"]
