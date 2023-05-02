# Tmux sessionist

Lightweight tmux utilities for manipulating tmux sessions.

Tested and working on Linux, OSX and Cygwin.

### Problem(s)

Sessions are a second class citizen in tmux environment:

- there are no default key bindings for creating or deleting sessions
- creating a session is cumbersome, just try `tmux new-session -s name`
  inside tmux (hint: you first have to detach)
- deleting (killing) current session by default detaches tmux (why?)
- no fast way for session switching when there's more than ~5 sessions

This plugin solves the above problems.

### Features

- `prefix + g` - prompts for session name and switches to it. Performs 'kind-of'
  name completion.<br/>
  Faster than the built-in `prefix + s` prompt for long session lists.
- `prefix + C` (shift + c) - prompt for creating a new session by name.
- `prefix + X` (shift + x) - kill current session without detaching tmux.
- `prefix + S` (shift + s) - switches to the last session.<br/>
  The same as built-in `prefix + L` that everyone seems to override with
  some other binding.
- `prefix + @` - promote current pane into a new session.<br/>
  Analogous to how `prefix + !` breaks current pane to a new window.
- `prefix + ctrl-@` - promote current window into a new session.
- `prefix + t<secondary-key>` - join currently marked pane (`prefix + m`) to current session/window, and switch to it
  - secondary-keys
    - `h`, `-`, `"`: join horizontally
    - `v`, `|`, `%`: join vertically
    - `f`, `@`: join full screen

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'tmux-plugins/tmux-sessionist'

Hit `prefix + I` to fetch the plugin and source it. You can now use the plugin.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/tmux-plugins/tmux-sessionist ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/sessionist.tmux

Reload TMUX environment with `$ tmux source-file ~/.tmux.conf`. You can now use
the plugin.

### Other plugins

You might also find these useful:

- [pain control](https://github.com/tmux-plugins/tmux-pain-control) - useful standard
  bindings for controlling panes
- [logging](https://github.com/tmux-plugins/tmux-logging) - easy logging and
  screen capturing

### License

[MIT](LICENSE.md)
