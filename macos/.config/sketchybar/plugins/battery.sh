#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"
COLOR="0xffe5e7eb"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

if [ -n "$CHARGING" ]; then
  COLOR="0xffe5e7eb"
elif [ "$PERCENTAGE" -le 15 ]; then
  COLOR="0xffe5e7eb"
elif [ "$PERCENTAGE" -le 30 ]; then
  COLOR="0xffe5e7eb"
fi

sketchybar --set "$NAME" icon.drawing=off label="${PERCENTAGE}%" label.color="$COLOR"
