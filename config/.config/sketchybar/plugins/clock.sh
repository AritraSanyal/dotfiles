#!/bin/sh
case "$NAME" in
  clock.hh) sketchybar --set "$NAME" label="$(date '+%H ')" ;;  # hours 
  clock.mm) sketchybar --set "$NAME" label="$(date '+%M ')" ;;  # minutes 
esac
