#!/bin/bash

calendar=(
  label.align=center
  update_freq=30
  script="$PLUGIN_DIR/calendar.sh"

  background.drawing=on
  background.color=$BG0
  background.height=35

  label.padding_left=10
  label.padding_right=15
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
