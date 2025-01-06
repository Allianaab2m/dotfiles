#!/bin/sh

SSID=$(ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}')

if [[ $SSID == "" ]]; then
  sketchybar --set wifi \
    icon=􀙈 \
    label=""
    # label="$SSID"
else
  sketchybar --set wifi \
    icon=􀙇  \
    label=""
    # label="$SSID"
fi

