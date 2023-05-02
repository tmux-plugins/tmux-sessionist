#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# global vars passed to the script as arguments
CURRENT_SESSION_NAME="$1"
CURRENT_WINDOW_ID="$2"
CURRENT_WINDOW_NAME="$3"
WINDOW_CURRENT_PATH="$4"

number_of_windows() {
	tmux list-windows -t "$CURRENT_SESSION_NAME" |
		wc -l |
		tr -d ' '
}

create_new_session() {
	TMUX="" tmux -S "$(tmux_socket)" new-session -c "$WINDOW_CURRENT_PATH" -s "$CURRENT_WINDOW_NAME" -d -P -F "#{session_name}"
}

new_session_window_id() {
	local session_name="$1"
	tmux list-windows -t "$session_name" -F "#{window_id}"
}

promote_window() {
	local session_name="$(create_new_session)"
	local new_session_window_id="$(new_session_window_id "$session_name")"
	tmux swap-window -s "$CURRENT_WINDOW_ID" -t "$new_session_window_id"
	tmux kill-window -t "$new_session_window_id"
	switch_to_session "$session_name"
}

main() {
	if [ "$(number_of_windows)" -gt 1 ]; then
		promote_window
	else
		display_message "Can't promote with only one window in session"
	fi
}
main
