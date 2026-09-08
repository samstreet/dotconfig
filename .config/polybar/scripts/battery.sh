#!/usr/bin/env bash
# Combines BAT0 + BAT1 (this laptop has two) into one percentage + icon.
set -uo pipefail

icon_bolt=$''
icon_full=$''
icon_3q=$''
icon_half=$''
icon_1q=$''
icon_empty=$''

now=0
full=0

for bat in /sys/class/power_supply/BAT*; do
    [ -d "$bat" ] || continue
    now=$(( now + $(cat "$bat/energy_now" 2>/dev/null || echo 0) ))
    full=$(( full + $(cat "$bat/energy_full" 2>/dev/null || echo 0) ))
done

[ "$full" -eq 0 ] && exit 0

pct=$(( now * 100 / full ))

charging=0
if [ -f /sys/class/power_supply/AC/online ] && [ "$(cat /sys/class/power_supply/AC/online)" = "1" ]; then
    charging=1
fi

if [ "$charging" = "1" ]; then
    icon=$icon_bolt
elif [ "$pct" -ge 90 ]; then
    icon=$icon_full
elif [ "$pct" -ge 60 ]; then
    icon=$icon_3q
elif [ "$pct" -ge 35 ]; then
    icon=$icon_half
elif [ "$pct" -ge 15 ]; then
    icon=$icon_1q
else
    icon=$icon_empty
fi

if [ "$charging" = "0" ] && [ "$pct" -le 15 ]; then
    echo "%{F#f38ba8}${icon} ${pct}%%{F-}"
else
    echo "${icon} ${pct}%"
fi
