# Tmux goto session

Tmux plugin for (very) fast session switching. Effective for a large number of
Tmux sessions.

**Problem**

Session switching for a large number of Tmux sessions **is slow**. Finding and
switching to the desired session in the below session list **takes seconds**.

![long list of sessions](/screenshots/sessions_list.png)

The main problem is: reading (visually parsing) long list of sessions is
slow and it needs to be avoided.

**Solution**

`tmux_goto_session` is a  "tell don't ask/read" principle applied to Tmux.

Just hit `prefix + g` (mnemonic for "goto") and start typing session name.
Most likely you already have the project/session name in your head and you
don't need to look it up.

![animated gif](/screenshots/tmux_goto_session.gif)

### Other features

- if you misspelled session name or session does not exist, `goto_session`
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
