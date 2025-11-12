#!/usr/bin/env bash
# NixOS-friendly Waybar volume control
# Usage: volume.sh [output|input] [raise|lower|mute]

set -euo pipefail

target="${1:-}"
action="${2:-}"

# Get the default sink/source using wpctl (works with PipeWire/WirePlumber)
case "$target" in
  output)
    # Find the default sink (marked with *) in the Audio section and extract its ID
    device=$(wpctl status | sed -n '/^Audio$/,/^Video$/p' | grep -A 20 "Sinks:" | grep " \* " | head -n1 | sed -E 's/.*\*\s*([0-9]+)\..*$/\1/')
    ;;
  input)
    # Find the default source (marked with *) in the Audio section and extract its ID
    device=$(wpctl status | sed -n '/^Audio$/,/^Video$/p' | grep -A 20 "Sources:" | grep " \* " | head -n1 | sed -E 's/.*\*\s*([0-9]+)\..*$/\1/')
    ;;
  *)
    echo "Usage: $0 [output|input] [raise|lower|mute]" >&2
    exit 1
    ;;
esac

# Check if device was found
if [ -z "$device" ]; then
  echo "Error: Could not find default $target device" >&2
  exit 1
fi

# Perform the requested action
case "$action" in
  raise) wpctl set-volume "$device" 5%+ ;;
  lower) wpctl set-volume "$device" 5%- ;;
  mute)  wpctl set-mute "$device" toggle ;;
  *) echo "Unknown action: $action" >&2; exit 1 ;;
esac
