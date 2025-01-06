#!/bin/sh

sketchybar --add event aerospace_workspace_change

space_creator=(
  icon=""
  icon.font="$FONT:Heavy:16.0"
  padding_right=0
  label.drawing=off
  display=active
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator q \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator aerospace_workspace_change

for m in $(aerospace list-monitors | awk '{print $1}'); do
  monitors=$(aerospace list-workspaces --monitor $m)

  for i in $(aerospace list-workspaces --monitor $m | sort -nr); do
    sid=$i
    space=(
      space="$sid"
      icon="$sid"
      icon.padding_right=10
      icon.padding_left=10
      icon.highlight_color=$RED
      icon.font="$FONT:Bold:14.0"
      display=$m
      padding_left=2
      padding_right=2
      label.padding_right=20
      label.color=$GREY
      label.highlight_color=$WHITE
      label.font="sketchybar-app-font:Regular:16.0"
      label.y_offset=-1
      background.padding_left=2
      background.color=$BG0
      background.border_color=$BG1
    background.height=35
      script="$PLUGIN_DIR/space.sh"
    )

    sketchybar --add space space.$sid q \
               --set space.$sid "${space[@]}" \
               --subscribe space.$sid mouse.clicked

    apps=$(aerospace list-windows --workspace $sid | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

    icon_strip=" "
    if [ "${apps}" != "" ]; then
      while read -r app
      do
        icon_strip+=" $(/Users/alliana/dotfiles/config/sketchybar/plugins/icon_map.sh "$app")"
      done <<< "${apps}"
    else
      icon_strip=" —"
    fi

    sketchybar --set space.$sid label="$icon_strip"
  done

  for i in $(aerospace list-workspaces --monitor $m --empty); do
    sketchybar --set space.$i display=0
  done
done

