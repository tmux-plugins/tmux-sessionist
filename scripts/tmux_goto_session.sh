#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

display_session_list() {
	tmux run-shell "$CURRENT_DIR/tmux_list_sessions.sh"
}

# Starts a loop: the command is invoked until correct session name is typed,
# or until prompt is cancelled with Ctrl-c or Enter.
show_goto_session_prompt() {
	tmux command-prompt -p session: "run '$CURRENT_DIR/switch_or_loop.sh %1'"
}

main() {
	display_session_list
	show_goto_session_prompt
}
main
