#!/bin/sh

echo "["

while true; do
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
    volume=$(echo "($volume * 100)/1" | bc)

    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    mic_mute=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk -F": " '{print $2}')

    sink=$(pactl get-default-sink)

    device=$(pactl list sinks | awk -v sink="$sink" '
        $1 == "Name:" && $2 == sink {
            found=1
        }

        found && $1 == "Description:" {
            sub(/^[ \t]*Description:[ \t]*/, "")
            print
            exit
        }
    ')

    bat_cap=$(cat /sys/class/power_supply/BAT0/capacity)
    battery_status=$(cat /sys/class/power_supply/BAT0/status)

    date_str=$(date +"%Y-%m-%d %X")

    if [ "$mute" = "no" ]; then
        volume_str="Volume (${device}): ${volume}%"
    else
        volume_str="Volume (${device}): MUTED"
    fi

    if [ "$mic_mute" = "no" ]; then
        mic_str="Mic: ON"
    else
        mic_str="Mic: MUTED"
    fi

    echo "${volume_str} | ${mic_str} | ${bat_cap}% (${battery_status}) | ${date_str}"

    sleep 1
done
