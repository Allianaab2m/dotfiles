#!/bin/sh

SSID=$(ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}')

sketchybar --set wifi \
  icon=􀙇  icon.color=0xff58d1fc \
  label=""
  # label="$SSID"

