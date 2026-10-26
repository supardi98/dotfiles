#!/bin/bash
LIST_FILE="/run/docker-always.list"

if [ -f "$LIST_FILE" ]; then
    # Tunggu socket docker siap menerima perintah
    for i in $(seq 1 30); do
        if /usr/bin/docker info >/dev/null 2>&1; then
            break
        fi
        sleep 0.1
    done

    # Kembalikan konfigurasi container ke "always" via docker update
    while read -r cid; do
        if [ -n "$cid" ]; then
            /usr/bin/docker update --restart=always "$cid" >/dev/null 2>&1 || true
        fi
    done < "$LIST_FILE"

    rm -f "$LIST_FILE"
fi
