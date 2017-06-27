is_macos() {
  [ $(uname) == "Darwin" ]
}

spotify_get() {
  if is_macos; then
    echo $(osascript -e "tell app \"Spotify\" to (${1}) as string")
  fi
}

spotify_running() {
  if is_macos; then
    echo $(osascript -e 'tell app "System Events" to (name of processes) contains "Spotify"')
  fi
}

spotify_playing() {
  echo $(spotify_get "player state")
}

spotify_artist() {
  echo $(spotify_get "artist of current track")
}

spotify_name() {
  echo $(spotify_get "name of current track")
}

spotify_album() {
  echo $(spotify_get "album of current track")
}

