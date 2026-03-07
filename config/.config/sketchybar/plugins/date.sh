#!/bin/bash

case "$NAME" in
  day)   sketchybar --set "$NAME" label="$(date '+%a')" ;;
  date)  sketchybar --set "$NAME" label="$(date '+%d' | sed 's/^0//')" ;;
  month) sketchybar --set "$NAME" label="$(date '+%b')" ;;
esac
