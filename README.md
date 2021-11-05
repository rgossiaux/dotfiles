# Setup

This repo is setup to work with GNU stow. The easiest way is to clone into the home directory, cd into the repository, and then `stow <folder>` for each folder (package). This will create symlinks for everything automatically in the home directory, matching the structure of the repository (so links are created from `~/foo` to `~/dotfiles/pkg/foo` for all foo). When adding new files, put them in the right place and re-run stow.

## Vim

vim-plug will automatically be installed when vim is launched. Then `:PlugInstall` will install all plugins.

`pyright` must be installed separately for Python LSP functionality. ALE will detect it automatically.

# Misc other setup
I use this terminal font: https://github.com/tonsky/FiraCode
I use iTerm2 as my terminal.

# Useful commands

## Shell

* Ctrl-R: fzf command history

## tmux

### Panes and Windows
```
* <prefix> v: Vertical split
* <prefix> s: Horizontal split
* <prefix> x: Kill pane
* <prefix> h/j/k/l: Switch panes

* <prefix> c: New window
* <prefix> &: Kill window
* <prefix> n: Next window
* <prefix> p: Previous window

* <prefix> ,: Name window
```
### Other
```
* <prefix> R: Reload tmux config
* <prefix> Ctrl-s: Save tmux state
* <prefix> Ctrl-r: Restore tmux state
```
