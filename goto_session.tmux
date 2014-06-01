#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

default_key_bindings="g C-g"
tmux_option="@goto_session_key"

# tmux show-option "q" (quiet) flag does not set return value to 1, even though
# the option does not exist. This function patches that.
get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo $default_value
	else
		echo $option_value
	fi
}

# Multiple bindings can be set. Default bindings are "g C-g".
set_goto_session_bindings() {
	local key_bindings=$(get_tmux_option "$tmux_option" "$default_key_bindings")
	for key in $key_bindings; do
		tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/tmux_goto_session.sh"
	done
}

main() {
	set_goto_session_bindings
}
main
