#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE_NAME=$(basename "${BASH_SOURCE[0]}")
CURRENT_SCRIPT="$CURRENT_DIR/$FILE_NAME"

# global variable, indicates whether script was called the first time, or was
# it a subsequent invocation
LOOP="$1"
SESSION_NAME="$2"

display_session_list() {
	tmux run-shell $CURRENT_DIR/tmux_list_sessions.sh
}

# Starts a loop: the command is invoked until correct session name is typed,
# or until prompt is cancelled with Ctrl-c or Enter.
# NOTE: `send-keys C-m` is invoked so session list page is dismissed from
# the current session.
show_goto_session_prompt() {
	tmux command-prompt -p session: " \
		send-keys C-m; \
		run-shell 'tmux switch-client -t %1 || $CURRENT_SCRIPT loop %1 '"
}

script_invoked_from_goto_prompt() {
	[ $LOOP == "loop" ]
}

session_name_not_provided() {
	[ -z "$SESSION_NAME" ]
}

cancel_goto_session_loop() {
	tmux send-keys C-m
	exit 0
}

main() {
	if script_invoked_from_goto_prompt && session_name_not_provided; then
		# "goto session loop" is broken when session name not provided
		cancel_goto_session_loop
	fi
	display_session_list
	show_goto_session_prompt
}
main
