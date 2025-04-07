#!/bin/bash

volume=(
  script="$PLUGIN_DIR/volume.sh"
  background.padding_right=8
)

sketchybar --add item volume right \
           --set volume "${volume[@]}" \
           --subscribe volume volume_change \
