#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
	# displayes tmux session list
	tmux run-shell "$CURRENT_DIR/tmux_list_sessions.sh"
	# invokes goto command prompt
	"$CURRENT_DIR/show_goto_prompt.sh"
}
main
