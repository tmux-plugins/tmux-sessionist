# Changelog

### master
- handle "promote pane" feature bug
- add `.gitattributes` file so that end of line chracter is always set to `\n`
  on cygwin
- speed up 'goto session' prompt
- fix creating new sessions with a '.' in the name

### v2.3.0, 2015-06-19
- split 'goto session' script into 2 files, make it simpler
- another 'goto session' feature refactoring
- add 'kill session' key binding
- refactor script names
- reduce duplication by moving some functions to a shared file

### v2.2.0, 2015-01-29
- bugfix: when a pane containing "vim" is promoted to a session, the moved pane
  has dimensions 80x25. This is the default `new-session -d` win size. Fixing
  this by first switching to a new session (so the window is resized), then
  pulling target pane over.
- 'goto-session' feature - when session list does not fit on the screen, show it
  in columns
- 'goto-session' - when all the sessions don't fit on the screen, the last
  displayed element is '...' indicating there's more sessions

### v2.1.0, 2015-01-11
- add a `@` key binding for "promoting" current pane into a new session

### v2.0.1, 2014-11-21
- fix bug, main script not working
- change tmux option variables to have hyphens instead of underscores (tmux
  uses hyphens)
- bugfix: when creating a new session, if there is a session 'ruby_foo', you
  can't create a session 'ruby'. Instead you would get switched to session
  'ruby_foo'.
- bugfix: creating a new session when using non-standard socket file. The
  command for creating new sessions now explicitly uses appropriate socket file.

### v2.0.0, 2014-08-03
- plugin name change
- revamp the readme
- update the plugin main file and user variables

### v1.2.0, 2014-08-03
- refactoring. Empty submission quits the 'goto loop'
- simplify readme
- add a `C` keybinding for creating new sessions
- add a 'create new session' feature to readme

### v1.1.0, 2014-07-30
- add other plugins list to the README
- update readme to reflect github organization change
- add alternate session key binding `prefix + S`

### v1.0.0, 2014-06-01

- tag version 1.0.0
