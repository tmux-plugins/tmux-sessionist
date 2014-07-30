#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

default_key_bindings="g"
tmux_option="@goto_session_key"

default_key_bindings_alternate="S"
tmux_option_alternate="@goto_alternate_session_key"

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

# Multiple bindings can be set. Default binding is "g".
set_goto_session_bindings() {
	local key_bindings=$(get_tmux_option "$tmux_option" "$default_key_bindings")
	local key
	for key in $key_bindings; do
		tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/tmux_goto_session.sh"
	done
}

set_alternate_session_binding() {
	local key_bindings=$(get_tmux_option "$tmux_option_alternate" "$default_key_bindings_alternate")
	local key
	for key in $key_bindings; do
		# switch to the last/alternate session
		tmux bind-key "$key" switch-client -l
	done
}


main() {
	set_goto_session_bindings
	set_alternate_session_binding
}
main
