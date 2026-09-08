#!/usr/bin/env bash
# Pending pacman updates. Empty output hides the module (no updates = no clutter).
set -uo pipefail

icon=$''
n=$(checkupdates 2>/dev/null | wc -l)

if [ "$n" -gt 0 ]; then
    echo "${icon} ${n}"
fi
