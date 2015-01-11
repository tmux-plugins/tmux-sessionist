# Changelog

### master

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
