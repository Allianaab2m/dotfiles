#!/bin/sh

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:18.0"

  icon.padding_right=5

  background.drawing=off
  background.height=35

  background.padding_left=-4

  label.padding_right=15
)

sketchybar --add item battery right \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke

