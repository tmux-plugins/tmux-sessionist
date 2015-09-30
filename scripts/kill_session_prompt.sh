#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# global vars passed to the script as arguments
CURRENT_SESSION_NAME="$1"
CURRENT_SESSION_ID="$2"

main() {
	tmux confirm -p "kill-session ${CURRENT_SESSION_NAME}? (y/n)" "run '$CURRENT_DIR/kill_session.sh \'$CURRENT_SESSION_ID''"
}
main
