#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/helpers.sh"

spotify_interpolation=(
  "\#{spotify_album}"
  "\#{spotify_artist}"
  "\#{spotify_name}"
  "\#{spotify_playing}"
  "\#{spotify_statusline}"
)

spotify_commands=(
  "#($CURRENT_DIR/scripts/spotify_album.sh)"
  "#($CURRENT_DIR/scripts/spotify_artist.sh)"
  "#($CURRENT_DIR/scripts/spotify_name.sh)"
  "#($CURRENT_DIR/scripts/spotify_playing.sh)"
  "#($CURRENT_DIR/scripts/spotify_statusline.sh)"
)

get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value="$(tmux show-option -gqv "$option")"
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

set_tmux_option() {
  local option=$1
  local value=$2
  tmux set-option -gq "$option" "$value"
}

do_interpolation() {
  local all_interpolated="$1"
  for ((i=0; i<${#spotify_commands[@]}; i++)); do
    all_interpolated=${all_interpolated/${spotify_interpolation[$i]}/${spotify_commands[$i]}}
  done
  echo "$all_interpolated"
}

update_tmux_option() {
  local option=$1
  local option_value=$(get_tmux_option "$option")
  local new_option_value=$(do_interpolation "$option_value")
  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}

main
