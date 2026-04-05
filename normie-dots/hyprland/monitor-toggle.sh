#!/usr/bin/env bash

INTERNAL=eDP-1
EXTERNAL=HDMI-A-1

while true; do
  if hyprctl monitors all | grep -q "$EXTERNAL"; then
    # HDMI plugged in → disable laptop, use external
    hyprctl keyword monitor "$INTERNAL, disable"
    hyprctl keyword monitor "$EXTERNAL, preferred, auto, 1"
  else
    # HDMI unplugged → enable laptop, disable HDMI
    hyprctl keyword monitor "$INTERNAL, preferred, auto, 1"
    hyprctl keyword monitor "$EXTERNAL, disable"
  fi
  sleep 2
done
