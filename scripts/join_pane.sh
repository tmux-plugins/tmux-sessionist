#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

create_new_window() {
 TMUX="" tmux -S "$(tmux_socket)" new-window -P -F
}

new_window_pane_id() {
  local new_window_id="$1"
  tmux list-panes -t "$new_window_id" -F "#{pane_id}"
}

join_pane() {
  local new_window_id="$(create_new_window)"
  local new_window_pane_id="$(new_window_pane_id "$new_window_id")"
  tmux join-pane -t "$new_window_pane_id"
  # tmux kill-pane -t "$new_window_pane_id"
}

main() {
  join_pane
}
main
