#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE_NAME=$(basename "${BASH_SOURCE[0]}")
CURRENT_SCRIPT="$CURRENT_DIR/$FILE_NAME"

# Programming Tmux is great!
#
# For example, take a look at the below line. It's by far the biggest hack of
# my life. Essentially this should be just:
# `tmux list-sessions -F "#{session_name}"`
#
# But that only shows the session list in the current shell, and we want a nice
# display across the whole screen.
# To achieve this, we wrap the above command in `tmux run-shell` like this:
# `tmux run-shell 'tmux list-sessions -F "#{session_name}"'`
#
# This does produce the "whole screen display" effect, but it also introduces a
# bug: `#{session_name}` is only expanded to the current session name, so you
# get a session list where only the name of the current session is displayed.
#
# So we hack what is already hacked. `#{session_name}` interpolation is split
# with the help of of `interpolation` variable.
# Wrapper command (`tmux run-shell`) won't perform interpolation and the inner
# `tmux list-sessions` command will.
tmux run-shell 'interpolation={session_name}; tmux list-sessions -F "#$interpolation"'

# Starts a loop: the command is invoked until correct session name is typed,
# or until prompt is cancelled with Ctrl-c.
tmux command-prompt -p session: " \
    send-keys C-c; \
    run-shell 'tmux switch-client -t %1 || $CURRENT_SCRIPT'"
