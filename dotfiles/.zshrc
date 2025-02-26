# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="agkozak"
# DEFAULT_USER="ericx"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Tells fzf plugin the base directory
[ -s ${HOME}/.vim/plugged/fzf/bin/fzf ] && export FZF_BASE=${HOME}/.vim/plugged/fzf

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode git fzf aliases)

source $ZSH/oh-my-zsh.sh

##################################
# User customization starts here #
##################################

###########################
# agkozak prompt settings #
###########################
AGKOZAK_BLANK_LINES=1
AGKOZAK_LEFT_PROMPT_ONLY=1
AGKOZAK_PROMPT_CHAR=( '%F{116}❯%f' '%F{116}❯%f' '%F{245}❮%f' )
AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' 'S')

AGKOZAK_COLORS_USER_HOST=108
AGKOZAK_COLORS_PATH=116
AGKOZAK_COLORS_BRANCH_STATUS=228
AGKOZAK_COLORS_EXIT_STATUS=174
AGKOZAK_COLORS_CMD_EXEC_TIME=245
AGKOZAK_COLORS_VIRTUALENV=188
AGKOZAK_COLORS_BG_STRING=223

################
# fzf settings #
################
# make fzf(fuzzy finder/filter) to use fdfind by default instead of find
# it follows symbolic links and includes hidden files (but exclude .git folders)
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
#if using fd's colored output inside fzf, add --ansi in the option and --color=always in the above command
export FZF_DEFAULT_OPTS="--ansi --height=60% --layout=reverse --info=inline --border"

#single quote tab completion behavior
#use ' as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER="''"

#use fd instead the default find for path completion
_fzf_compgen_path() {
  fd --hidden --exclude ".git" . "$1"
}

#use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --exclude ".git" . "$1"
}

# Add fzf completion in bash for other commands
# Only needed for bash
#_fzf_setup_completion path bat dpkg
#_fzf_setup_completion dir tree

#fzf ctrl-t and alt-c behavior
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude .git"
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_COMMAND="fd -t d --hidden --follow --exclude .git"
export FZF_ALT_C_OPTS="--height=60% --preview 'tree -C {} | head -200'"

#############################
# vi-mode addition settings #
#############################
MODE_INDICATOR="%F{white}%B>%b%f"
INSERT_MODE_INDICATOR="%F{yellow}%B<%b%f"
VI_MODE_SET_CURSOR=true
VI_MODE_CURSOR_NORMAL=2 # solid block
VI_MODE_CURSOR_VISUAL=1 # blinking block
VI_MODE_CURSOR_INSERT=6 # solid line

#######################
# set Z shell options #
#######################
setopt nomatch
setopt notify

################
# Xilinx tools #
################
# Add xilinx tools to path vairable so vim can use it
[ -f /tools/Xilinx/Vitis/2024.2/settings64.sh ] && source /tools/Xilinx/Vitis/2024.2/settings64.sh 1>/dev/null
export TRAINING_PATH="$HOME/training"

################
# NVM settings #
################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#########
# Alias #
#########
# Define new or redefine alias by oh-my-zsh
alias l='ls -CF'
alias la='ls -aCF'
alias lla='ls -alFh'
alias ll='ls -lFh'

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

########
# MISC #
########
# add fd(fd-find) to the executable path
export PATH=$HOME/.local/bin:$PATH

# Test if we are running MS WSL Linux or native Linux
# If the formmer is true then the terminal is controlled by windows terminal
if grep -qi microsoft /proc/version; then
  export TERM_UBUNTU=0
else
  export TERM_UBUNTU=1
fi

# Required by gnupg on headless system such as wsl2
export GPG_TTY=$(tty)

# Do not use less if content fits one screen, ANSI color escape sequences will handled
export LESS="-FR"
