#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# global variable
SESSION_NAME="$1"

source "$CURRENT_DIR/helpers.sh"

session_name_not_provided() {
	[ -z "$SESSION_NAME" ]
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
		#
		# -c "#{pane_current_path}" has to be specified, otherwise a random path is
		# used for the new session.
		local session_name=$(TMUX="" tmux -S "$(tmux_socket)" new-session -d -P -c "#{pane_current_path}" -s "$SESSION_NAME")
		switch_to_session "$session_name"
	fi
}

main() {
	create_new_tmux_session
}
main
