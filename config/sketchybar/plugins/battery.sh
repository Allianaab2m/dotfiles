#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"
DRAWING=on

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case ${PERCENTAGE} in
  [8-9][0-9] | 100)
    ICON="􀛨"
    ;;
  7[0-9])
    ICON="􀺸"
    ;;
  [4-6][0-9])
    ICON="􀺶"
    ;;
  [1-3][0-9])
    ICON="􀛩"
    ;;
  [0-9])
    ICON="􀛪"
    ;;
esac

if [[ "$CHARGING" != "" ]]; then
  ICON="􀢋"
  DRAWING=off
fi

sketchybar --set "$NAME" drawing=$DRAWING icon="$ICON" label="${PERCENTAGE}%"
