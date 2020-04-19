# ----------------------------------------------------------------------------
# Zsh configuration, managed with zplug
# https://github.com/zplug/zplug
# ----------------------------------------------------------------------------
#
ZPLUG_HOME=~/.zplug

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
    source $ZPLUG_HOME/init.zsh && zplug update --self
fi

source $ZPLUG_HOME/init.zsh

# self-manage zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# # theme
zplug romkatv/powerlevel10k, as:theme, depth:1

# custom plugins
zplug "sheoak/zsh-bepoptimist", defer:2

# oh-my-zsh plugins
zplug "plugins/git", from:oh-my-zsh, defer:2
zplug "plugins/git-extras", from:oh-my-zsh, defer:2
zplug "plugins/gitfast", from:oh-my-zsh, defer:2
zplug "plugins/colorize", from:oh-my-zsh, defer:2
zplug "plugins/vi-mode", from:oh-my-zsh, defer:2
zplug "plugins/virtualenvwrapper", from:oh-my-zsh, defer:2
zplug "plugins/z", from:oh-my-zsh, defer:2
zplug "plugins/fzf", from:oh-my-zsh, defer:2

# generic plugins
# FZF on CTRL-R
zplug "$DOTFILES_PRIVATE/oh-my-zsh/plugins/fz", from:local, defer:3
# FZF on CTRL-G
zplug "$DOTFILES_PRIVATE/oh-my-zsh/plugins/fzf-z", from:local, defer:3
zplug "$DOTFILES_PRIVATE/oh-my-zsh/plugins/fzftools", from:local, defer:3
zplug "$DOTFILES_PRIVATE/oh-my-zsh/plugins/tty-solarized", from:local, defer:3

# private confs and plugins
zplug "$DOTFILES_PRIVATE", from:local, use:zshrc, defer:2
zplug "$DOTFILES_PRIVATE/oh-my-zsh/plugins/common-aliases", from:local, defer:2
zplug "$DOTFILES_PRIVATE/oh-my-zsh/plugins/private-aliases", from:local, defer:2

# zsh settings
setopt menu_complete

# bindings
bindkey '^F' fzf-cd-widget
bindkey '^[[Z' reverse-menu-complete

# history
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# custom theme
# https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt
VIRTUAL_ENV_DISABLE_PROMPT=1
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='15'
POWERLEVEL9K_BATTERY_HIDE_ABOVE_THRESHOLD='20'
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_DISK_USAGE_ONLY_WARNING=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv vcs background_jobs disk_usage battery)
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='black'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='cyan'
POWERLEVEL9K_DIR_HOME_FOREGROUND='black'
POWERLEVEL9K_DIR_HOME_BACKGROUND='cyan'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='cyan'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='black'
POWERLEVEL9K_DIR_FOLDER_BACKGROUND='cyan'
POWERLEVEL9K_DIR_FOLDER_FOREGROUND='black'
POWERLEVEL9K_DIR_ETC_BACKGROUND='cyan'
POWERLEVEL9K_DIR_ETC_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='purple'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='black'
POWERLEVEL9K_VIRTUALENV_BACKGROUND='white'
POWERLEVEL9K_VCS_UNTRACKED_ICON=''
POWERLEVEL9K_VCS_UNSTAGED_ICON=''
POWERLEVEL9K_BACKGROUND_JOBS_ICON=''
POWERLEVEL9K_BATTERY_ICON=''
POWERLEVEL9K_VCS_STASH_ICON='  '
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=' '
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=' '
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLINE_DETECT_SSH="true"
POWERLINE_RIGHT_B="none"

# fix ssh issues with kitty
if [ "$TERM" != 'linux' ]; then
  export TERM=xterm-256color
else
  POWERLEVEL9K_IGNORE_TERM_COLORS=true
  POWERLEVEL9K_MODE='Powerlevel9k'
fi

export KEYTIMEOUT=1     # faster vim transitions

# Paths
export NODE_PATH="$NODE_PATH:$HOME/.local/share/npm/lib/node_modules"
export JAVA_HOME="/usr/lib/jvm/java-12-openjdk"
export PATH="$PATH:$HOME/bin:$HOME/.gem/ruby/2.5.0/bin:$HOME/.local/bin"
export PATH="$PATH:$DOTFILES_PRIVATE/bin:$HOME/.local/share/npm/bin"
export PATH="$PATH:$DOTFILES_LOCAL/bin"
export PATH=$JAVA_HOME/bin:$PATH
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
# Dirty hack to fix /usr/bin/node that is not a directory
export PATH=$(echo "$PATH" | sed -e 's/:\/usr\/bin\/node//')

# Default executable
export BROWSER=firefox

# use lesspipe
export LESSOPEN="|lesspipe.sh %s"
export LESS='-R '
# no less history
export LESSHISTFILE=/dev/null

# FZF settings
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --ignore-file $DOTFILES_PRIVATE/agignore --hidden '
export FZF_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_OPTS='+c -x'
export FZF_CTRL_R_OPTS=""
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --theme=TwoDark --color=always {} | head -100' --preview-window='right' --bind 'ctrl-b:toggle-preview'"
export FZF_CTRL_T_COMMAND='rg --files --no-ignore-vcs --ignore-file $DOTFILES_PRIVATE/agignore --hidden '
export FZF_DEFAULT_OPTS="--inline-info --reverse --prompt='❯' --preview-window='right:50%' --bind '?:toggle-preview'"
export FZF_PREVIEW_COMMAND="bat --style=numbers --theme=TwoDark --color=always {} | head -100"

# GPG settings
export GPG_TTY=`tty`
echo "UPDATESTARTUPTTY" | gpg-connect-agent > /dev/null 2>&1

# Use bat for man
export MANPAGER="sh -c 'col -bx | bat --theme="TwoDark" -l man -p'"
# MANROFFOPT="-c"

# startx if on tty1
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx &>/dev/null
fi

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load
