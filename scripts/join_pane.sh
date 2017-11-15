#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# where the secondary key bindings are bound
SECONDARY_KEY_TABLE="join-pane"

# more of a convenient sentinel for the full screen join
BREAK_PANE_FLAG="-b"

# passed to script on the 2-key binding invocation
JOIN_PANE_FLAG="$1"

source "$CURRENT_DIR/helpers.sh"

join_pane() {
  local join_pane_flag="$1"
	tmux join-pane "$join_pane_flag" || \
    tmux display-message "Mark a(nother) pane first"

  if [ "$BREAK_PANE_FLAG" == "$join_pane_flag" ]; then
   tmux break-pane || true
  fi
}

bind_secondary_keys() {
  while read -r key flag; do
    tmux bind-key -T"$SECONDARY_KEY_TABLE" "$key" \
         run "'$CURRENT_DIR/join_pane.sh' '$flag'"
  done <<KEY_FLAGS
h -h
% -h
| -h
v -v
" -v
- -v
f $BREAK_PANE_FLAG
@ $BREAK_PANE_FLAG
KEY_FLAGS
}

main() {
  if [ -z "$JOIN_PANE_FLAG"]; then
    bind_secondary_keys
    tmux switch-client -T"$SECONDARY_KEY_TABLE"
  else
    join_pane "$JOIN_PANE_FLAG"
  fi

}
main
