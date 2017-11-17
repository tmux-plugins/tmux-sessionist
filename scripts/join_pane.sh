#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# where the secondary key bindings are bound
SECONDARY_KEY_TABLE="$1"
# sentinel for the full screen join that's also safe to pass to `join-pane`
BREAK_PANE_FLAG="$2"
# passed to script on the 2-key binding invocation
JOIN_PANE_FLAG="$3"

source "$CURRENT_DIR/helpers.sh"

join_pane() {
	local join_pane_flag="$1"
	tmux join-pane "$join_pane_flag" || \
		tmux display-message "Mark a(nother) pane first"

	if [ "$BREAK_PANE_FLAG" == "$join_pane_flag" ]; then
	 tmux break-pane || true
	fi
}

main() {
	if [ -z "$JOIN_PANE_FLAG"]; then
		tmux switch-client -T"$SECONDARY_KEY_TABLE"
	else
		join_pane "$JOIN_PANE_FLAG"
	fi
}
main
