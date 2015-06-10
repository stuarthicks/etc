export TERM=screen-256color
bindkey -v
bindkey "^W" backward-kill-word    # vi-backward-kill-word
bindkey "^H" backward-delete-char  # vi-backward-delete-char
bindkey "^U" kill-line             # vi-kill-line
bindkey "^?" backward-delete-char  # vi-backward-delete-char
export KEYTIMEOUT=1

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

zmodload zsh/complist
autoload -Uz compinit compdef && compinit
setopt completealiases
source ~/.aliases

# ALL the history options!
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt APPENDHISTORY
setopt SHAREHISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

setopt MULTIOS # pipe to multiple outputs.
#setopt EXTENDEDGLOB # e.g. cp ^*.(tar|bz2|gz)
setopt RM_STAR_WAIT
setopt AUTOPUSHD
setopt PUSHDMINUS
setopt PUSHDSILENT
setopt PUSHDTOHOME
setopt AUTOCD
setopt INTERACTIVECOMMENTS
setopt NOCLOBBER # prevents accidentally overwriting an existing file.
setopt NOMATCH # If a pattern for filename has no matches = error.
setopt PRINT_EXIT_VALUE
setopt LONG_LIST_JOBS

# Makes Arrow keys, Home/End, etc, work in more obscure terminals (eg, st)
function zle-line-init () { echoti smkx }
function zle-line-finish () { echoti rmkx }
zle -N zle-line-init
zle -N zle-line-finish

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    kill -9 %+
    zle redisplay
  else
    zle push-input
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Meta-u to chdir to the parent directory
bindkey -s '\eu' '^Ucd ..; ls^M'

# If AUTO_PUSHD is set, Meta-p pops the dir stack
bindkey -s '\ep' '^Upopd >/dev/null; dirs -v^M'

# # Pipe the current command through less
bindkey -s "\el" " 2>&1|less^M"

# Show how long a job takes
REPORTTIME=1

export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"
autoload colors && colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats "%{$fg_bold[black]using%} %{$reset_color%}%s% %{$fg_bold[black]on%} %F{2}%b%F{3}|%F{1}%a%F{5}%f"
zstyle ':vcs_info:*' formats "%{$fg_bold[black]using%} %{$reset_color%}%s %{$fg_bold[black]on%} %F{5}%F{2}%b%F{5}%f"
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git svn

vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$reset_color%}%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del "
  fi
}

precmd() {
    vcs_info
}

# Allow for functions in the prompt.
setopt PROMPT_SUBST

cosmos_info() {
  COSMOS_INSTANCE=""
  COSMOS_COLOUR=""
  if [ -f "/etc/cosmos-info" ]; then
    source "/etc/cosmos-info"
    if [ "$COSMOS_ENV" != "int" ] && [ "$COSMOS_ENV" != "test" ] ; then
      echo "%{$reset_color%}%F{red}%{$COSMOS_ENV%} %{$COSMOS_COMPONENT%}%f "
    else
      echo "%{$reset_color%}%F{green}%{$COSMOS_ENV%} %{$COSMOS_COMPONENT%}%f "
    fi
  fi
}

# $USER at $HOSTNAME in $CWD (vcs_info/cosmos_info)
PROMPT="%F{cyan}%n%f \
%{$fg_bold[black]%}at \
%F{yellow}%m%f \
%{$fg_bold[black]%}in \
%F{white}%9c%f \
\$(vcs_info_wrapper)\$(cosmos_info)
%{$fg[red]%}$%{$reset_color%} "

function zle-line-init zle-keymap-select {
  VIM_PROMPT="%{$fg_bold[yellow]%} [% N]%  %{$reset_color%}"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

RPROMPT='${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}'

COMPLETION_WAITING_DOTS="true"

unsetopt correct_all

bindkey '^R' history-incremental-search-backward
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
bindkey '^a' beginning-of-line # Home
bindkey '^e' end-of-line # End
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char

# esc/meta-e to edit current command in $EDITOR
autoload edit-command-line && zle -N edit-command-line
bindkey '\ee' edit-command-line

zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:descriptions' format '%U%d%u'
zstyle ':completion:*:warnings' format 'No matches for: %B%d%b'
zstyle ':completion:*' menu select=2 # show menu when at least 2 options.
zstyle ':completion::complete:cd::' tag-order '! users' - # do not auto complete user names
zstyle ':completion:*' tag-order '! users' # listing all users takes ages.

bindkey -M menuselect "=" accept-and-menu-complete

export VISUAL=vim
export EDITOR=$VISUAL

# Set title of window
title () {
    printf "\033k$1\033\\"
}

# Echo path with newlines
path () {
    echo $PATH | tr : $'\n'
}

# List all items on path
lspath () {
  (($#)) || set ''
  print -lr -- $^path/*$^@*(N:t) | sort -u
}

wgetar () {
    wget -q0 - "$1" | tar xzvf -
}

LANG=en_GB.UTF-8
LANGUAGE=en_GB.UTF-8

build-something () {
  if [ -x "build" ]; then
    BUFFER="./build"
  elif [ -f "pom.xml" ]; then
    BUFFER="dev m clean install"
  elif [ -x "test" ]; then
    BUFFER="with-aws tmp ./test"
  elif [ -x "configure" ]; then
    BUFFER="./configure && make"
  elif [ -f "Makefile" ]; then
    BUFFER="make"
  elif [ -f "Gemfile" ]; then
    BUFFER="bundle exec cucumber --strict --expand -t ~@browser-required"
  fi
  zle end-of-line
}
zle -N build-something
bindkey '^G' build-something # Go!

start-jetty() {
  BUFFER="with-aws tmp m -f *war/*xml jetty:run"
  zle end-of-line
}
zle -N start-jetty
bindkey '^V' start-jetty

export ZSH=$HOME

# curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > antigen.zsh
if ls ~/antigen.zsh &>/dev/null; then
  source ~/antigen.zsh
  antigen bundles <<EOBUNDLES
  rupa/z
  colored-man
  extract
  rsync
  tmux
EOBUNDLES
  antigen apply
  # zsh-users/zsh-syntax-highlighting
  # mosh
fi

if [ -f "$HOME/cloud_python/bin/activate" ]; then
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  source $HOME/cloud_python/bin/activate
fi

alias -- -='vim -R -'
