#!/usr/bin/env bash

export PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

# Theme persistence file
THEME_FILE="$HOME/.config/sketchybar/.theme"

# Default theme if none exists
[[ -f "$THEME_FILE" ]] || echo "transparent" > "$THEME_FILE"

export OX_THEME=$(cat "$THEME_FILE")

# -----------------------------
# Transparent theme (glass)
# -----------------------------
export OX_BG_TRANSPARENT="0xaa16181a"
export OX_FG_TRANSPARENT="0xffe0e0e0"
export OX_DIM_TRANSPARENT="0xff7b8496"
export OX_MG_TRANSPARENT="0xffff5ef1"
export OX_ORG_TRANSPARENT="0xff5ef1ff"
export OX_BORDER_TRANSPARENT="0xff3a3a3c"

# -----------------------------
# Dark theme (solid black)
# -----------------------------
export OX_BG_DARK="0xff000000"
export OX_FG_DARK="0xffe0e0e0"
export OX_DIM_DARK="0xff7b8496"
export OX_MG_DARK="0xffff5ef1"
export OX_ORG_DARK="0xff5ef1ff"
export OX_BORDER_DARK="0xff3a3a3c"

# -----------------------------
# Apply selected theme
# -----------------------------
if [[ "$OX_THEME" == "dark" ]]; then
  export OX_BG="$OX_BG_DARK"
  export OX_FG="$OX_FG_DARK"
  export OX_DIM="$OX_DIM_DARK"
  export OX_MG="$OX_MG_DARK"
  export OX_ORG="$OX_ORG_DARK"
  export OX_BORDER="$OX_BORDER_DARK"
else
  export OX_THEME="transparent"
  export OX_BG="$OX_BG_TRANSPARENT"
  export OX_FG="$OX_FG_TRANSPARENT"
  export OX_DIM="$OX_DIM_TRANSPARENT"
  export OX_MG="$OX_MG_TRANSPARENT"
  export OX_ORG="$OX_ORG_TRANSPARENT"
  export OX_BORDER="$OX_BORDER_TRANSPARENT"
fi

# -----------------------------
# Bar configuration
# -----------------------------
export SB_BAR=(
  position=left
  height=60
  sticky=on
  topmost=off
  shadow=off
  y_offset=10
  margin=10
  padding_left=16
  padding_right=16
  color="$OX_BG"
  border_color="$OX_BORDER"
  border_width=1
  corner_radius=12
  font_smoothing=on
  blur_radius=30
)

# -----------------------------
# Default item styling
# -----------------------------
export SB_DEFAULT=(
  icon.font.family="Hack Nerd Font Mono"
  icon.font.style="Regular"
  icon.font.size=13
  icon.color="$OX_DIM"

  label.font.family="Source Code Pro"
  label.font.style="Regular"
  label.font.size=13
  label.color="$OX_MG"

  padding_left=10
  padding_right=10
  icon.padding_right=4
  icon.highlight_color="$OX_MG"
)
