#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SESSION_NAME="$1"

dismiss_session_list_page_from_view() {
	tmux send-keys C-m
}

session_name_not_provided() {
	[ -z "$SESSION_NAME" ]
}

main() {
	dismiss_session_list_page_from_view
	if session_name_not_provided; then
		exit 0
	fi
	tmux switch-client -t "$SESSION_NAME" ||
		"$CURRENT_DIR/tmux_goto_session.sh" "$SESSION_NAME"
}
main
