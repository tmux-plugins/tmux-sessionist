#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# global vars passed to the script as arguments
CURRENT_SESSION_ID="$1"
CURRENT_PANE_ID="$2"
PANE_CURRENT_COMMAND="$3"
PANE_CURRENT_PATH="$4"

number_of_panes() {
	tmux list-panes -s -t "$CURRENT_SESSION_ID" |
		wc -l |
		tr -d ' '
}

create_new_session() {
	TMUX="" tmux -S "$(tmux_socket)" new-session -c "$PANE_CURRENT_PATH" -d -P -F "#{session_id}"
}

new_session_pane_id() {
	local session_id="$1"
	tmux list-panes -t "$session_id" -F "#{pane_id}"
}

rename_session_to_pane() {
	local new_session_name="$PANE_CURRENT_COMMAND"
	name_collisions="$(number_of_session_collisions "$new_session_name")"
	[ "$name_collisions" -gt 0 ] &&
		new_session_name="$new_session_name-$((name_collisions+1))"
  tmux rename-session -t "$1" "$new_session_name"
}

promote_pane() {
	local session_id="$(create_new_session)"
	local new_session_pane_id="$(new_session_pane_id "$session_id")"
	tmux swap-pane -s "$CURRENT_PANE_ID" -t "$new_session_pane_id"
	tmux kill-pane -t "$new_session_pane_id"
	rename_session_to_pane "$session_id"
	switch_to_session "$session_id"
}

main() {
	if [ "$(number_of_panes)" -gt 1 ]; then
		promote_pane
	else
		display_message "Can't promote with only one pane in session"
	fi
}
main
