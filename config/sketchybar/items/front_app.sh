#!/bin/sh

front_app=(
  label.font="$FONT:Bold:12.0"
  icon.background.drawing=on
  display=active

  script="$PLUGIN_DIR/front_app.sh"

  background.drawing=off
  background.height=35
  background.padding_right=15

  background.padding_left=0

  label.padding_left=15
)

sketchybar --add item front_app left         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched

