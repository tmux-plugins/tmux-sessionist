#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
	tmux command-prompt -p "new session name:" "run-shell '$CURRENT_DIR/tmux_new_session.sh %1'"
}
main
