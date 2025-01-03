#!/bin/sh

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:18.0"
  update_freq=120
  updates=on

  icon.padding_right=5
  icon.padding_left=15

  background.drawing=off
  background.height=35

  background.padding_left=0

  label.padding_right=15
)

sketchybar --add item battery right \
           --set battery "${battery[@]}"\
              icon.font.size=15 update_freq=120 script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery power_source_change system_woke

