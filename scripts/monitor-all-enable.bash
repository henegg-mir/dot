#!/usr/bin/env bash
LEN=$(swaymsg -t get_outputs | jq -r .'|length')

for ((i = 0; i < LEN; i++)); do
NAME=$(swaymsg -t get_outputs | jq -r .'['$i'].name')
(swaymsg output "$NAME" enable)
done
