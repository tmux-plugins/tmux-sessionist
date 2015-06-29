#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# global vars passed to the script as arguments
CURRENT_SESSION_ID="$1"

switch_to_next_session() {
	tmux switch-client -n
}

switch_to_alternate_session() {
	tmux switch-client -l
}

alternate_session_name() {
	tmux display -p "#{client_last_session}"
}

current_session_name() {
	tmux display -p "#{client_session}"
}

number_of_sessions() {
	tmux list-sessions |
		wc -l |
		sed "s/ //g"
}

# Setting `detach-on-destroy off` will also switch session, but it does not
# respect alternate session.
switch_session() {
	local alternate_session_name="$(alternate_session_name)"
	if [ "$(number_of_sessions)" -eq 1 ]; then
		# this is the only session, do nothing and wait for tmux server death
		return 0
	elif [ -z "$alternate_session_name" ]; then
		# alternate session does not exist
		switch_to_next_session
	elif [ "$alternate_session_name" == "$(current_session_name)" ]; then
		# current session IS alternate session
		switch_to_next_session
	else
		switch_to_alternate_session
	fi
}

kill_current_session() {
	tmux kill-session -t "$CURRENT_SESSION_ID"
}

main() {
	switch_session
	kill_current_session
}
main
