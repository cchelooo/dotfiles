#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"
  COLOR="0xffe7edf5"

  case "$VOLUME" in
    [6-9][0-9]|100) ICON="󰕾"
    ;;
    [3-5][0-9]) ICON="󰖀"
    ;;
    [1-9]|[1-2][0-9]) ICON="󰕿"
    ;;
    *) ICON="󰖁"
  esac

  if [ "$VOLUME" = "0" ]; then
    COLOR="0xfff87171"
  fi

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%" icon.color="$COLOR" label.color="$COLOR"
fi
