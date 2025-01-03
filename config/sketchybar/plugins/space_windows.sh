#!/usr/bin/env bash
 
source "/Users/alliana/dotfiles/config/sketchybar/colors.sh"

AEROSPACE_FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')
AEROSPACE_WORKSPACE_FOCUSED_MONITOR=$(aerospace list-workspaces --monitor focused --empty no)
AEROSPACE_EMPTY_WORKESPACE=$(aerospace list-workspaces --monitor focused --empty)

reload_workspace_icon() {
  apps=$(aerospace list-windows --workspace "$@" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi

  sketchybar --animate sin 10 --set space.$@ label="$icon_strip"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  reload_workspace_icon "$AEROSPACE_PREV_WORKSPACE"
  reload_workspace_icon "$AEROSPACE_FOCUSED_WORKSPACE"

  sketchybar --animate sin 10 --set space.$space label="$icon_strip"

  # current workspace space border color
  sketchybar --animate sin 10 --set space.$AEROSPACE_FOCUSED_WORKSPACE icon.highlight=true \
                         label.highlight=true \
                         background.border_color=$GREY

  # prev workspace space border color
  sketchybar --animate sin 10 --set space.$AEROSPACE_PREV_WORKSPACE icon.highlight=false \
                         label.highlight=false \
                         background.border_color=$BG2

  for i in $AEROSPACE_WORKSPACE_FOCUSED_MONITOR; do
    sketchybar --animate sin 10 --set space.$i display=$AEROSPACE_FOCUSED_MONITOR
  done

  for i in $AEROSPACE_EMPTY_WORKESPACE; do
    sketchybar --animate sin 10 --set space.$i display=0
  done

  sketchybar --animate sin 10 --set space.$AEROSPACE_FOCUSED_WORKSPACE display=$AEROSPACE_FOCUSED_MONITOR

fi
