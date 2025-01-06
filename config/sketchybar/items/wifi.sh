#!/bin/sh

POPUP_OFF="sketchybar --set wifi.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set wifi popup.drawing=toggle"

wifi=(
  label.drawing=off

  icon.font="$FONT:Regular:16.0"
  script="$PLUGIN_DIR/wifi.sh"

  icon.padding_left=15
  icon.padding_right=6

  background.drawing=off
  background.height=35

  background.padding_right=0

  click_script="$POPUP_CLICK_SCRIPT"
  popup.height=35

  icon=􀙈
)

wifi_ssid=(
  label="$(ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}')"
)

sketchybar --add item wifi right
sketchybar --set wifi "${wifi[@]}"
sketchybar --subscribe wifi wifi_change
