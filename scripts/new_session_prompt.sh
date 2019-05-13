#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SESSION_START_DIR="$1"

main() {
	tmux command -p "new session name:" "run '$CURRENT_DIR/new_session.sh \"%1\" \"$SESSION_START_DIR\"'"
}
main
