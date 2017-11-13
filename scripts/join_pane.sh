#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
JOIN_KEY="$1"

source "$CURRENT_DIR/helpers.sh"

join_prompt() {
  tmux command-prompt -1 \
    -p 'join-pane - horizontal: (h % |) vertical: (v " -) full: (f @) ' \
    "run \"'$CURRENT_DIR/join_pane.sh' '%%%'\""
}

join_pane() {
  local join_pane_flag="$1"
	tmux join-pane "$join_pane_flag" || \
    tmux display-message "Mark a(nother) pane first"

  if [ "-b" == "$join_pane_flag" ]; then
   tmux break-pane || true
  fi
}

main() {
  if [ -z "$JOIN_KEY" ]; then
    join_prompt
  else
    local join_pane_flag
    case $JOIN_KEY in
      'h') join_pane_flag="-h";;
      '%') join_pane_flag="-h";;
      '|') join_pane_flag="-h";;
      'v') join_pane_flag="-v";;
      '"') join_pane_flag="-v";;
      '-') join_pane_flag="-v";;
      'f') join_pane_flag="-b";;
      '@') join_pane_flag="-b";;
    esac

    if [ -z "$join_pane_flag" ]; then
      tmux display-message "invalid key"
    else
      join_pane "$join_pane_flag"
    fi
  fi
}
main
