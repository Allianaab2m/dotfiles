#!/bin/sh

TITLE=$(echo $INFO | jq -r ".title")
ARTIST=$(echo $INFO | jq -r ".artist")
STATE=$(echo $INFO | jq -r ".state")

if [[ $STATE == "playing" ]]; then
  sketchybar --animate sin 10 --set "$NAME" icon="􀊕" label="$TITLE - $ARTIST" label.scroll_duration=400
elif [[ $STATE == "paused" ]]; then
  sketchybar --animate sin 10 --set "$NAME" icon="􀊗" label="$TITLE - $ARTIST" label.scroll_duration=0
fi

