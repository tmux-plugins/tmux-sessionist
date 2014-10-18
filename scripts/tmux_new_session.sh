#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# global variable
SESSION_NAME="$1"
SESSION_PATH="$2"

source "$CURRENT_DIR/helpers.sh"

default_sessionist_use_pane_directory=""
tmux_option_sessionist_use_pane_directory="@sessionist-use-pane-directory"

session_name_not_provided() {
	[ -z "$SESSION_NAME" ]
}

session_exists() {
	tmux has-session -t "$SESSION_NAME" > /dev/null 2>&1
}

switch_to_session() {
	local session_name="$1"
	tmux switch-client -t "$session_name"
}

create_new_tmux_session() {
	local use_pane_directory=$(get_tmux_option "$tmux_option_sessionist_use_pane_directory" "$default_sessionist_use_pane_directory")
	local tmux_extra_args=""

	if [ "$use_pane_directory" = "true" ] ;then
		tmux_extra_args=" -c $SESSION_PATH "
	fi

	if session_name_not_provided; then
		exit 0
	elif session_exists; then
		switch_to_session "$SESSION_NAME"
		display_message "Switched to existing session ${SESSION_NAME}" "1000"
	else
		TMUX="" tmux new $tmux_extra_args -d -s "$SESSION_NAME"
		switch_to_session "$SESSION_NAME"
	fi
}

main() {
	create_new_tmux_session
}
main
