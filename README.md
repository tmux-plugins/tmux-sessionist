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

`tmux-goto-session` is a  "tell don't ask" principle applied to Tmux.

Just hit `prefix + g` (mnemonic for "goto") and start typing session name.
Most likely you already have the project/session name in your head and you
don't need to look it up.

![animated gif](/screenshots/tmux_goto_session.gif)

### Other features

- if you misspelled session name or session does not exist, `goto-session`
  prompt is automatically invoked again. Hit `Enter` to stop this "loop".
- you can type just the minimum number of letters from the session name.<br/>
  Example: you have sessions `project`, `ruby` and `javascript`. Typing just
  `p`, `r` or `j` in `goto-session` prompt will switch you to the respective
  project.<br/>
  This is actually a Tmux feature and it helps a lot.
- `prefix + S` switches to the last session
- `prefix + C` prompt for creating a new session by name

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @tpm_plugins "                \
      tmux-plugins/tpm                   \
      tmux-plugins/tmux-goto-session     \
    "

Hit `prefix + I` to fetch the plugin and source it. You can now use the plugin.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/tmux-plugins/tmux-goto-session ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/goto_session.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You can now use the plugin.

### Configuration

To change default key binding to, for example `prefix + *`, put this in `.tmux.conf`:

    set-option -g @goto_session_key "*"

Don't forget to reload TMUX environment (`$ tmux source-file ~/.tmux.conf`)
after you do this.

### Other plugins

You might also find these useful:

- [pain control](https://github.com/tmux-plugins/tmux-pain-control) - useful standard
  bindings for controlling panes
- [logging](https://github.com/tmux-plugins/tmux-logging) - easy logging and
  screen capturing

### License

[MIT](LICENSE.md)
