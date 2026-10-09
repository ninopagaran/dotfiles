#!/bin/sh

LOG="$HOME/.local/state/noisetorch-start.log"

mkdir -p "$(dirname "$LOG")"

exec >>"$LOG" 2>&1

echo
echo "========== NoiseTorch startup $(date) =========="

# Wait for PipeWire/Pulse compatibility layer.
i=0
while ! pactl info >/dev/null 2>&1; do
    i=$((i + 1))

    if [ "$i" -ge 100 ]; then
        echo "ERROR: PipeWire/Pulse server did not become available"
        exit 1
    fi

    sleep 0.1
done

echo "Audio server available"

# Wait until a real default microphone exists.
i=0
physical_source=""

while [ "$i" -lt 100 ]; do
    physical_source=$(pactl get-default-source 2>/dev/null || true)

    case "$physical_source" in
        "")
            ;;
        *noisetorch*|*NoiseTorch*)
            physical_source=""
            ;;
        *.monitor)
            physical_source=""
            ;;
        *)
            break
            ;;
    esac

    i=$((i + 1))
    sleep 0.1
done

if [ -z "$physical_source" ]; then
    echo "ERROR: No physical microphone became available"
    pactl list short sources
    exit 1
fi

echo "Physical microphone: $physical_source"

# Check if NoiseTorch already exists.
nt_source=$(pactl list short sources |
    awk -F '\t' 'tolower($2) ~ /noisetorch/ { print $2; exit }')

if [ -z "$nt_source" ]; then
    echo "Starting NoiseTorch"

    noisetorch -i -s "$physical_source"

    # Wait for the virtual microphone.
    i=0

    while [ "$i" -lt 100 ]; do
        nt_source=$(pactl list short sources |
            awk -F '\t' 'tolower($2) ~ /noisetorch/ { print $2; exit }')

        [ -n "$nt_source" ] && break

        i=$((i + 1))
        sleep 0.1
    done
fi

if [ -n "$nt_source" ]; then
    echo "NoiseTorch source: $nt_source"

    pactl set-default-source "$nt_source"

    echo "NoiseTorch successfully configured"

    noisetorch -t 20
else
    echo "ERROR: NoiseTorch source never appeared"
    exit 1
fi
