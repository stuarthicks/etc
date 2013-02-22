# Start with emacs keybindings
bindkey -e

# ALL the history options!
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

setopt APPENDHISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt NOBANGHIST

setopt MULTIOS # pipe to multiple outputs.
setopt EXTENDEDGLOB # e.g. cp ^*.(tar|bz2|gz)
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

# Alt-S inserts "sudo " at the start of line.
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# Meta-u to chdir to the parent directory
bindkey -s '\eu' '^Ucd ..; ls^M'

# If AUTO_PUSHD is set, Meta-p pops the dir stack
bindkey -s '\ep' '^Upopd >/dev/null; dirs -v^M'

# # Pipe the current command through less
bindkey -s "\el" " 2>&1|less^M"

# Show how long a job takes
REPORTTIME=1

# Terminal colour magic that I don't understand
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

red="\033[1;31m"
norm="\033[0;39m"
cyan="\033[1;36m"

solarized_green="\033[0;32m"
solarized_red="\033[0;31m"
solarized_blue="\033[0;34m"
solarized_yellow="\033[0;33m"

PROMPT='%n :: %m <%3c> ' # TODO: COLORS
RPS1='> %?'

DISABLE_AUTO_UPDATE="true"

# DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="true"

plugins=(git gem github ruby)

set -o extendedglob
unsetopt correct_all

# Customize to your needs...
export PATH=~/.gem/ruby/1.9.1/bin/:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/vendor_perl:/usr/bin/core_perl

bindkey '^R' history-incremental-search-backward
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
bindkey '^a' beginning-of-line # Home
bindkey '^e' end-of-line # End
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char

zmodload zsh/complist
autoload -Uz compinit
compinit

setopt COMPLETEALIASES

zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:descriptions' format '%U%d%u'
zstyle ':completion:*:warnings' format 'No matches for: %B%d%b'
zstyle ':completion:*' menu select=2 # show menu when at least 2 options.
zstyle ':completion::complete:cd::' tag-order '! users' - # do not auto complete user names
zstyle ':completion:*' tag-order '! users' # listing all users takes ages.

bindkey -M menuselect "=" accept-and-menu-complete

alias v='vim'
alias q='exit'
alias :q='exit'
alias vd='svn diff -x -b | vim -'
alias ll='ls -lah'
alias pp='ps aux | grep'
alias find-pacman-orphans='sudo pacman -Rs $(pacman -Qtdq)'
alias freemem='sync; sudo echo 3 > /proc/sys/vm/drop_caches'
alias psh='perl -d -e 1'
alias g='grep'
alias a='ack -ai'
alias pp='ps aux | grep'
alias pstree='ps -AHwef'
alias dc='cd'
alias sg="find . \( \( ! -name .svn -and ! -name target \) -o -prune \) -type f -print0 | xargs -0 grep --color"
alias gg="find . \( \( ! -name .git -and ! -name target \) -o -prune \) -type f -print0 | xargs -0 grep --color"
alias dus='du -sh *'
alias t='tail'
alias tf='tail -f'
alias serve='python -m SimpleHTTPServer 8000'

export EDITOR=vim
export VISUAL=vim

settitle () {
    printf "\033k$1\033\\"
}

path () {
    echo $PATH | tr : $'\n'
}

wgetar () {
    wget -q0 - "$1" | tar xzvf -
}

LANG=en_GB.UTF-8
LANGUAGE=en_GB.UTF-8
