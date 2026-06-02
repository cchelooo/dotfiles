#!/usr/bin/env bash

MAX_APPS=4
sid="${NAME#workspace.}"
active_color="0xffffffff"
inactive_color="0x9ee7edf5"

focused="$(aerospace list-workspaces --focused 2>/dev/null)"

if [ "$focused" = "$sid" ]; then
  color="$active_color"
else
  color="$inactive_color"
fi

sketchybar --set "workspace.$sid" icon.color="$color"

apps="$(
  aerospace list-windows --workspace "$sid" --format '%{app-name}' 2>/dev/null \
    | awk 'NF && !seen[$0]++'
)"

slot=1

while IFS= read -r app; do
  [ -z "$app" ] && continue
  [ "$slot" -gt "$MAX_APPS" ] && break

  icon="$("$CONFIG_DIR/plugins/icon_map.sh" "$app")"

  sketchybar --set "workspace.$sid.app.$slot" \
    icon="$icon" \
    icon.color="$color" \
    drawing=on

  slot=$((slot + 1))
done <<< "$apps"

while [ "$slot" -le "$MAX_APPS" ]; do
  sketchybar --set "workspace.$sid.app.$slot" drawing=off
  slot=$((slot + 1))
done
