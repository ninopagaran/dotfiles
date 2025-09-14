#!/bin/bash
# Low battery notifier

# Kill already running processes
already_running="$(ps -fC 'grep' -N | grep 'batt.sh' | wc -l)"
if [[ $already_running -gt 1 ]]; then
	pkill -f --older 1 'batt.sh'
fi

while [[ 0 -eq 0 ]]; do
	battery_status="$(cat /sys/class/power_supply/BAT1/status)"
	battery_charge="$(cat /sys/class/power_supply/BAT1/capacity)"

	if [[ $battery_status == 'Discharging' && $battery_charge -le 85 ]]; then
		if   [[ $battery_charge -le 15 ]]; then
			notify-send --urgency=critical "Battery critical!" "${battery_charge}%"
			sleep 180
		elif [[ $battery_charge -le 25 ]]; then
			notify-send --urgency=critical "Battery critical!" "${battery_charge}%"
			sleep 240
		fi
	else
		sleep 600
	fi
done
