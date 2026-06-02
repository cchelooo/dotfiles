#!/usr/bin/env bash

app_name="$INFO"

if [ -z "$app_name" ]; then
  app_name="$(aerospace list-windows --focused --format '%{app-name}' 2>/dev/null)"
fi

if [ -z "$app_name" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

icon="$("$CONFIG_DIR/plugins/icon_map.sh" "$app_name")"

sketchybar --set "$NAME" icon="$icon" drawing=on
