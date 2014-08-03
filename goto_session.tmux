#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

default_key_bindings="g"
tmux_option="@goto_session_key"

default_key_bindings_alternate="S"
tmux_option_alternate="@goto_alternate_session_key"

default_key_bindings_new="C"
tmux_option_new="@goto_new_session_key"

source "$CURRENT_DIR/scripts/helpers.sh"

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

# Prompt for creating a new session. If the session with the same name exists,
# it will switch to existing session.
set_new_session_binding() {
	local key_bindings=$(get_tmux_option "$tmux_option_new" "$default_key_bindings_new")
	local key
	for key in $key_bindings; do
		tmux bind-key "$key" "$CURRENT_DIR/scripts/tmux_new_session_prompt.sh"
	done
}

main() {
	set_goto_session_bindings
	set_alternate_session_binding
	set_new_session_binding
}
main
