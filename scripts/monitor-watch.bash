#!/usr/bin/env bash
MONITOR=$1
LEN=$(swaymsg -t get_outputs | jq -r .'|length')

for ((i = 0; i < LEN; i++)); do
SERIAL=$(swaymsg -t get_outputs | jq -r .'['$i'].serial')
if ((MONITOR == SERIAL)); then
CURRENT=$i
break
fi
done

ACTIVE=$(swaymsg -t get_outputs | jq -r .'['"$CURRENT"'].active')

if [ "$ACTIVE" = "false" ]; then
echo '{"alt" : "active", "class" : "active"}'
else
echo '{"alt" : "deactive", "class" : "deactive"}'
fi
