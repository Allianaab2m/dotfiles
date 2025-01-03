#!/bin/bash

POPUP_OFF='sketchybar --set apple.logo popup.drawing=off'
POPUP_CLICK_SCRIPT='sketchybar --set $NAME popup.drawing=toggle'

apple_logo=(
  label.drawing=off

  icon=􀣺
  icon.font="$FONT:Black:16.0"
  icon.color=$WHITE

  icon.padding_right=15
  icon.padding_left=15

  background.drawing=off

  background.padding_right=0

  click_script="$POPUP_CLICK_SCRIPT"
  popup.height=35
)

apple_prefs=(
  icon=$PREFERENCES
  label="Preferences"
  click_script="open -a 'System Preferences'; $POPUP_OFF"
)

apple_lock=(
  icon=$LOCK
  label="Lock Screen"
  click_script="pmset displaysleepnow; $POPUP_OFF"
)

sketchybar --add item apple.logo left                  \
           --set apple.logo "${apple_logo[@]}"         \
                                                       \
           --add item apple.prefs popup.apple.logo     \
           --set apple.prefs "${apple_prefs[@]}"       \
                                                       \
           --add item apple.lock popup.apple.logo      \
           --set apple.lock "${apple_lock[@]}"
