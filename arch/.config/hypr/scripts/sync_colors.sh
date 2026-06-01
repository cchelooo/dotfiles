#!/bin/bash
COLOR_FILE="$HOME/.config/noctalia/colors.json"
OUTPUT_FILE="$HOME/.config/hypr/colors.conf"

if [ -f "$COLOR_FILE" ]; then
    # Extraemos el color mPrimary y mSecondary usando jq
    PRIMARY=$(jq -r '.mPrimary' "$COLOR_FILE" | sed 's/#//')
    SECONDARY=$(jq -r '.mSecondary' "$COLOR_FILE" | sed 's/#//')
    
    # Escribimos el archivo para Hyprland
    echo "\$mPrimary = rgba(${PRIMARY}ee)" > "$OUTPUT_FILE"
    echo "\$mSecondary = rgba(${SECONDARY}ee)" >> "$OUTPUT_FILE"
fi
