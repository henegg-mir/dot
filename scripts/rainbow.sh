#!/usr/bin/env bash

# Your text
text_1="☆.。.:*・°☆.。.:*・°☆.。.:*・°☆"
text_2="☆°・*:.。.☆°・*:.。.☆°・*:.。.☆"
text="$text_1"
if [ "$1" == "-r" ]; then text="$text_1";
else text="$text_2";
fi

# Pastel rainbow colors
colors=( "#FFB3B3" "#FFCCB3" "#FFE0B3" "#FFF1B3" "#D9FFB3" "#B3FFCC" "#B3E0FF" "#C8B3FF" "#FFB3D9" "#FFB3CC" "#FFCCA8" "#FFE0B3" "#E0FFB3" "#B3FFCC" "#B3D9FF" "#C8B3FF" "#FFB3E0" "#FFB3CC" "#FFD9B3" "#FFE0B3" "#D9FFB3" "#B3FFCC" )

while true; do
    output=""
    for i in $(seq 0 $((${#text}-1))); do
        char="${text:i:1}"
        color="${colors[i % ${#colors[@]}]}"
        output+="<span color=\"$color\">$char</span>"
    done

    # Print to stdout for Waybar, flush immediately
    printf "%s\n" "$output"
    
    # Rotate colors for animation
    if [ "$1" == "-r" ]; then colors=( "${colors[@]:1}" "${colors[0]}" );
    else colors=( "${colors[-1]}" "${colors[@]:0:${#colors[@]}-1}" );
    fi
    
    # Delay between frames (adjust for speed)
    sleep 0.3
done
