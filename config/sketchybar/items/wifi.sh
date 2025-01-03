#!/bin/sh

POPUP_OFF="sketchybar --set wifi.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set wifi popup.drawing=toggle"

wifi=(
  label.drawing=off

  icon.font="$FONT:Regular:18.0"
  script="$PLUGIN_DIR/wifi.sh"
  icon.color=0xffffffff
  update_freq=60

  icon.padding_left=15

  background.drawing=off
  background.height=35

  background.padding_right=0

  click_script="$POPUP_CLICK_SCRIPT"
  popup.height=35
)

wifi_ssid=(
  label="$(ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}')"
)

sketchybar --add item wifi right
sketchybar --add item wifi.ssid popup.wifi

sketchybar --set wifi.ssid "${wifi_ssid[@]}"
sketchybar --set wifi "${wifi[@]}"
