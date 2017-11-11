#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

join_pane() {
  tmux join-pane
  tmux break-pane
}

main() {
  join_pane
}
main
