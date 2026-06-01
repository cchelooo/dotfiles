#!/bin/bash
# Buscamos la dirección interna de la primera ventana que esté en el dock/escondite
WIN_ADDRESS=$(hyprctl clients -j | jq -r '.[] | select(.workspace.name == "special:minimized") | .address' | head -n 1)

if [ -n "$WIN_ADDRESS" ]; then
    # Si encontramos una, la obligamos a moverse al espacio de trabajo actual (e+0)
    hyprctl dispatch movetoworkspace e+0,address:$WIN_ADDRESS
fi
