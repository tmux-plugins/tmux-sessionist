#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# global vars passed to the script as arguments
CURRENT_WINDOW_ID="$1"
CURRENT_PANE_ID="$2"
CURRENT_PANE_TITLE="${2//%}"
PANE_CURRENT_PATH="$3"

number_of_panes() {
	tmux list-panes -t "$CURRENT_WINDOW_ID" |
		wc -l |
		tr -d ' '
}

create_new_session() {
	if [ "$(get_tmux_option "@sessionist-maintain-path")" == "on" ]; then
		TMUX="" tmux -S "$(tmux_socket)" new-session -c "$PANE_CURRENT_PATH" -s "se-$CURRENT_PANE_TITLE" -d -P -F "#{session_name}"
	else
		TMUX="" tmux -S "$(tmux_socket)" new-session -s "se-$CURRENT_PANE_TITLE" -d -P -F "#{session_name}"
	fi
}

session_pane_id() {
	local session_name="$1"
	tmux list-panes -t "$session_name" -F "#{pane_id}"
}

promote_pane() {
	if [ -n "$(session_pane_id "$CURRENT_PANE_TITLE")" ]; then
		CURRENT_PANE_TITLE="$CURRENT_PANE_TITLE^"
	fi
	local session_name="$(create_new_session)"
	local session_pane_id="$(session_pane_id "$session_name")"
	tmux join-pane -s "$CURRENT_PANE_ID" -t "$session_pane_id"
	tmux kill-pane -t "$session_pane_id"
	switch_to_session "$session_name"
}

main() {
	if [ "$(number_of_panes)" -gt 1 ]; then
		promote_pane
	else
		display_message "Can't promote with only one pane in window"
	fi
}
main
