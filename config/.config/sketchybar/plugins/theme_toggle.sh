#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/sketchybar"
THEME_FILE="$CONFIG_DIR/.theme"

# Ensure theme file exists
[[ -f "$THEME_FILE" ]] || echo "transparent" > "$THEME_FILE"

CURRENT_THEME=$(cat "$THEME_FILE")

if [[ "$CURRENT_THEME" == "dark" ]]; then
  NEXT_THEME="transparent"
  ICON="󰔎"
else
  NEXT_THEME="dark"
  ICON="󰔎"
fi

if [[ "$SENDER" == "mouse.clicked" ]]; then
  echo "$NEXT_THEME" > "$THEME_FILE"
  sketchybar --reload
  exit 0
fi

sketchybar --set theme_toggle icon="$ICON"
