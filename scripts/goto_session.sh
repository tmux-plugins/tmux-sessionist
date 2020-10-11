#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
	tmux run-shell -b "$CURRENT_DIR/list_sessions.sh | fzf-tmux | xargs tmux switch-client -t || true"
}
main
