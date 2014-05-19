#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE_NAME=$(basename "${BASH_SOURCE[0]}")
CURRENT_SCRIPT="$CURRENT_DIR/$FILE_NAME"

# Nested invocation used so that output is displayed across the whole screen.
tmux run-shell "tmux list-sessions -F '#{session_name}'"

# Starts a loop: the command is invoked until correct session name is typed,
# or until prompt is cancelled with Ctrl-c.
tmux command-prompt -p session: " \
    send-keys C-c; \
    run-shell 'tmux switch-client -t %1 || $CURRENT_SCRIPT'"
