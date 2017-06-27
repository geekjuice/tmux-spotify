#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

truncate() {
  local length=36
  if [[ ${#1} -gt $length ]]; then
    echo "$(echo $1 | cut -c 1-$length)..."
  else
    echo $1
  fi
}

spotify_statusline() {
  if [[ "$(spotify_running)" == true ]]; then
    local name=$(truncate "$(spotify_name)")
    local artist=$(truncate "$(spotify_artist)")
    local status="$name - $artist"
    if [[ "$(spotify_playing)" == playing ]]; then
      echo "♫ $status"
    else
      echo "$status"
    fi
  else
    echo "♫"
  fi
}

spotify_statusline
