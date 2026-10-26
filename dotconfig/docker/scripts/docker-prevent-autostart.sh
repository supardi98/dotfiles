#!/bin/bash
# Simpan daftar container yang memiliki policy always
LIST_FILE="/run/docker-always.list"
rm -f "$LIST_FILE"

# Ganti sementara "Name":"always" menjadi "Name":"no" pada hostconfig.json
for f in /var/lib/docker/containers/*/hostconfig.json; do
    if [ -f "$f" ]; then
        if grep -q '"RestartPolicy":{"Name":"always"' "$f"; then
            container_id=$(basename "$(dirname "$f")")
            echo "$container_id" >> "$LIST_FILE"
            sed -i 's/"RestartPolicy":{"Name":"always"/"RestartPolicy":{"Name":"no"/g' "$f"
        fi
    fi
done
