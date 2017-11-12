#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

JOIN_PANE_FLAG="$1"

join_pane() {
	if [ $(tmux join-pane "JOIN_PANE_FLAG") -gt 0 ]; then
    tmux display-message "Mark a(nother) pane first"
  elif [ -z "JOIN_PANE_FLAG" ]
    tmux break-pane
  fi
}

main() {
  join_pane
}
main
