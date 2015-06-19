#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# global variable
SESSION_NAME="$1"

source "$CURRENT_DIR/helpers.sh"

session_name_not_provided() {
	[ -z "$SESSION_NAME" ]
}

session_exists() {
	tmux list-sessions -F "#{session_name}" |
		\grep -q "^${SESSION_NAME}$"
}

switch_to_session() {
	local session_name="$1"
	tmux switch-client -t "$session_name"
}

tmux_socket() {
	echo $TMUX | cut -d',' -f1
}

create_new_tmux_session() {
	if session_name_not_provided; then
		exit 0
	elif session_exists; then
		switch_to_session "$SESSION_NAME"
		display_message "Switched to existing session ${SESSION_NAME}" "1000"
	else
		TMUX="" tmux -S "$(tmux_socket)" new-session -d -s "$SESSION_NAME"
		switch_to_session "$SESSION_NAME"
	fi
}

main() {
	create_new_tmux_session
}
main
