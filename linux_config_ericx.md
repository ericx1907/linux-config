This file describes how to set a linux(Ubuntu) work environment in work with configuration files in [dotfiles](dotfiles)

--- 

## GIT and GITHUB configuration

1. Install Git using apt
2. Install GCM (git credential manager) and configure Git to use GCM
3. configure GCM to use GPG/pass.

## FZF (command line fuzzy finder and selector)

There are two main ways to install [fzf](https://github.com/junegunn/fzf):

1. Clone the [repo](https://github.com/junegunn/fzf) and run the `install` script. The user has to source a script (.fzf.bash) generated after the build to enable autocomplete and keybinds.

2. Install fzf using APT. In this way user needs to sources the complete and keybind script by itself.

These configurations are all covered in both [.zshrc](dotfiles/.zshrc) and [.bashrc](dotfiles/.bashrc). 


