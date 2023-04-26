#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# global vars passed to the script as arguments
CURRENT_WINDOW_ID="$1"
CURRENT_PANE_ID="$2"
PANE_CURRENT_PATH="$3"

number_of_panes() {
	tmux list-panes -t "$CURRENT_WINDOW_ID" |
		wc -l |
		tr -d ' '
}

create_new_session() {
	if [ "$(get_tmux_option "@sessionist-maintain-path")" == "on" ]; then
		TMUX="" tmux -S "$(tmux_socket)" new-session -c "$PANE_CURRENT_PATH" -d -P -F "#{session_id}"
	else
		TMUX="" tmux -S "$(tmux_socket)" new-session -d -P -F "#{session_id}"
	fi
}

session_pane_id() {
	local session_id="$1"
	tmux list-panes -t "$session_id" -F "#{pane_id}"
}

promote_pane() {
	local session_id="$(create_new_session)"
	local session_pane_id="$(session_pane_id "$session_id")"
	tmux join-pane -s "$CURRENT_PANE_ID" -t "$session_pane_id"
	tmux kill-pane -t "$session_pane_id"
	switch_to_session "$session_id"
	CURRENT_PANE_TITLE=$(tmux display-message -p "#{pane_current_command}")
	tmux rename-session -t "$session_id" "$CURRENT_PANE_TITLE+"
}

main() {
	if [ "$(number_of_panes)" -gt 1 ]; then
		promote_pane
	else
		display_message "Can't promote with only one pane in window"
	fi
}
main
