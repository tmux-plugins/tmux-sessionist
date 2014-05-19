# Tmux goto session

Tmux plugin for (very) fast session switching. Effective for a large number of
Tmux sessions.

**Problem**

Tmux built-in interactive session selector (bound to `prefix + s` by default)
is great. But in case you have large number of Tmux sessions, reading from the
session list (visually parsing it), finding the session number and finally
pressing it **is slow**.

This is especially true if you juggle 10+ sessions/projects.

We need something faster. Something where a session list does not need to be
visually parsed - because that's the slowest action.

**Solution**

`tmux_goto_session` enables you to switch sessions without having to read
through the session list. It's a "tell don't ask" principle applied to Tmux.

It enables you to hit `prefix + g` (mnemonic for "go") and start typing session
name. Hit `Enter` and you're switched. Just typing like this should be a faster.

### Other features

- if you misspelled section name or section does not exist, `goto_session`
  prompt is automatically invoked again. Hit `C-c` to stop this "loop".
- you can type just the minimum unambiguous number of letters from the session
  name.<br/>
  Example: you have sessions `project`, `ruby` and `javascript`. Typing just
  `p`, `r` or `j` in `goto_session` prompt will switch you to the respective
  project.<br/>
  This is actually a Tmux feature and it helps a lot.

### Installation with [Tmux Plugin Manager](https://github.com/bruno-/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @tpm_plugins "              \
      bruno-/tpm                       \
      bruno-/tmux_goto_session         \
    "

Hit `prefix + I` to fetch the plugin and source it.

You can now press `prefix + g` to invoke `goto_session`.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/bruno-/tmux_goto_session ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/goto_session.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You can now press `prefix + g` to invoke `goto_session`.

### Configuration

You can set `@goto_session_key` Tmux option to choose which key is
`goto_session` bound to.

For example, to set it to `prefix + *` (asterisk) put this in `.tmux.conf`:

    set-option -g @goto_session_key "*"

Don't forget to reload TMUX environment (`$ tmux source-file ~/.tmux.conf`)
after you do this.

### License

[MIT](LICENSE.md)
