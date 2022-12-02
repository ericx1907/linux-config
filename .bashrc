# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# Write current command immediately to history file
# Read new lines from history file to current session
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=50000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -AF'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# set the environment for ISE
# source /opt/Xilinx/14.7/ISE_DS/settings64.sh

#this command will load the necessary library for Xilinx impact to work
if [ -s /opt/Xilinx/14.7/usb-driver/libusb-driver.so ]; then 
  export LD_PRELOAD=/opt/Xilinx/14.7/usb-driver/libusb-driver.so
fi

#set the shell in vi mode
set -o vi

#start powerline status bar
if [ -s /usr/share/powerline/bindings/bash/powerline.sh ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bindings/bash/powerline.sh
fi

#add fd(fdfind) to the executable path
export PATH=$HOME/.local/bin:$PATH

#change bat theme to zenburn
export BAT_THEME="zenburn"

#fzf settings 
#make fzf(fuzzy finder/filter) to use fdfind by default instead of find
#it follows symbolic links and includes hidden files (but exclude .git folders)
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git' 
#if using fd's colored output inside fzf, add --ansi in the option and --color=always in the above command
export FZF_DEFAULT_OPTS="--ansi --height=90% --layout=reverse --info=inline --border"

# if fzf is installed by git then source the offical script to enable  
# autocomplete and keybinds
if [ -s ~/.fzf.bash ]; then
  source ~/.fzf.bash
else
# source script if installed by apt package manager
  if [ -s /usr/share/bash-completion/completions/fzf ]; then
    source /usr/share/bash-completion/completions/fzf
  fi
  if [ -s /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
  fi
fi

#single quote tab completion behavior
#use ' as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER="''"

#use fd instead the default find for path completion
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

#use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

#add fzf completion in bash for other commands
_fzf_setup_completion path bat
_fzf_setup_completion dir tree

#fzf ctrl-t and alt-c behavior
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude .git"
export FZF_ALT_C_COMMAND="fd -t d --hidden --follow --exclude .git"
export FZF_ALT_C_OPTS="--height=60% --preview 'tree -C {} | head -200'"

#Enable Xilinx tools
if [ -s /tools/Xilinx/Vivado/2022.1/settings64.sh ]; then
  source /tools/Xilinx/Vivado/2022.1/settings64.sh
fi

#Load nvm (node version manager) in each shell session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#Tell vim we are using Ubuntu terminal
export TERM_UBUNTU=1
