export TERM=screen-256color

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

REPORTTIME=1

export LSCOLORS="Gxfxcxdxbxegedabagacad"

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

#source ~/.profile
zstyle ':completion::complete:cd::' tag-order '! users' - # do not auto complete user names
zstyle ':completion:*' tag-order '! users' # listing all users takes ages.

alias quack=perl -lpe 's/(\w{5,})/"qu" . ("a" x (length($1)-4)) . "ck"/eg\'
alias t='tmux'
alias v='vim'
alias svd='svn diff -x -b | vim -'
alias ll='ls -lah'
alias pp='ps aux | grep'
alias orphans='sudo pacman -Rs $(pacman -Qtdq)'
alias freemem='sync; sudo echo 3 > /proc/sys/vm/drop_caches'
alias psh='perl -d -e 1'
alias g='grep'
alias psg='ps aux | grep'
alias pstree='ps -AHwef'
alias :q='exit'
alias dc='cd'
alias svngrep="find . \( \( ! -name .svn -and ! -name target \) -o -prune \) -type f -print0 | xargs -0 grep --color"
alias gitgrep="find . \( \( ! -name .git -and ! -name target \) -o -prune \) -type f -print0 | xargs -0 grep --color"
alias dus='du -sh *'
alias t='tail'
alias tf='tail -f'

export EDITOR=vim
export VISUAL=vim

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxexexabagacad

red="\033[1;31m"
norm="\033[0;39m"
cyan="\033[1;36m"

solarized_green="\033[0;32m"
solarized_red="\033[0;31m"
solarized_blue="\033[0;34m"
solarized_yellow="\033[0;33m"

settitle () {
    printf "\033k$1\033\\"
}

set_remote_panes() {
    #tmux set-environment 's' "ssh '$@'"
    tmux unbind-key \\
    tmux unbind-key -
    tmux bind-key \\ split-window -h "ssh '$@'"
    tmux bind-key - split-window -v "ssh '$@'"
}

unset_remote_panes() {
    tmux unbind-key \\
    tmux unbind-key -
    tmux bind-key \\ split-window -h
    tmux bind-key - split-window -v
}

#ssh () {
#    settitle "$*"
#    set_remote_panes "$@"
#    ssh "$@"
#    unset_remote_panes
#}

path () {
    echo $PATH | tr : $'\n'
}

wgetar () {
    wget -q0 - "$1" | tar xzvf -
}

LANG=en_GB.UTF-8
LANGUAGE=en_GB.UTF-8
