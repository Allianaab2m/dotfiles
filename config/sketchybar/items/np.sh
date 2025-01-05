#!/bin/sh

np=(
    icon.font="$FONT:Regular:18.0"
    script="$PLUGIN_DIR/np.sh"

    label.max_chars=28
    label.scroll_duration=400
    icon.color=0xffffffff

    icon.padding_right=10
    icon.padding_left=15

    background.padding_left=8
    background.drawing=on
    background.color=$BG0
    background.height=35

    label="Loading..."
    label.padding_right=15
)

sketchybar --add item np e

sketchybar --set np "${np[@]}"

sketchybar --subscribe np media_change
