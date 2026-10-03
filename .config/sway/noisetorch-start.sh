#!/bin/sh

# Check whether a NoiseTorch virtual microphone already exists.
nt_source=$(pactl list short sources |
    awk -F '\t' 'tolower($2) ~ /noisetorch/ { print $2; exit }')

if [ -z "$nt_source" ]; then
    # Remember the real microphone before NoiseTorch changes anything.
    physical_source=$(pactl get-default-source)

    # Load NoiseTorch explicitly on that microphone.
    noisetorch -i -s "$physical_source"

    # Wait for the virtual microphone to appear.
    i=0
    while [ "$i" -lt 50 ]; do
        nt_source=$(pactl list short sources |
            awk -F '\t' 'tolower($2) ~ /noisetorch/ { print $2; exit }')

        [ -n "$nt_source" ] && break

        sleep 0.1
        i=$((i + 1))
    done
fi

# Make NoiseTorch the default microphone once it exists.
if [ -n "$nt_source" ]; then
    pactl set-default-source "$nt_source"
fi
