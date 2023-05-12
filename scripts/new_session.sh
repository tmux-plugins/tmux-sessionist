#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# global variable
SESSION_NAME="$1"

source "$CURRENT_DIR/helpers.sh"

session_name_not_provided() {
	[ -z "$SESSION_NAME" ]
}

create_named_session() {
	if [ "$(get_tmux_option "@sessionist-maintain-path")" == "on" ]; then
		TMUX="" tmux -S "$(tmux_socket)" new-session -c "$1" -s "$2" -d -P -F "#{session_id}"
	else
		TMUX="" tmux -S "$(tmux_socket)" new-session         -s "$2" -d -P -F "#{session_id}"
	fi
}

create_new_tmux_session() {
	if session_name_not_provided; then
		exit 0
	elif session_exists_exact; then
		switch_to_session "$SESSION_NAME"
		display_message "Switched to existing session ${SESSION_NAME}" "2000"
	else
		# New session name may differ from the input. Eg input name may be
		# 'foo.bar', but new name will be 'foo_bar'.
		local pane_current_path=$(tmux display-message -p "#{pane_current_path}")
		local session_id=$(create_named_session "$pane_current_path" "$SESSION_NAME")
		switch_to_session "$session_id"
	fi
}

main() {
	create_new_tmux_session
}
main
