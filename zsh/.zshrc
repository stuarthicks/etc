# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ttyctl -f  # Disable suspending the terminal with ctrl-s
bindkey -e # Default keybindings to "emacs" style

autoload -Uz colors && colors

# Auto escape pasted urls correctly (ie, if not pasted within quotes).
autoload -Uz url-quote-magic       && zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic && zle -N bracketed-paste bracketed-paste-magic

# Press meta-e to open current command prompt in EDITOR.
# Save and quit to execute buffer.
autoload -Uz  edit-command-line
zle      -N   edit-command-line
bindkey '\ee' edit-command-line

KEYTIMEOUT=1

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt auto_pushd
setopt extended_history
setopt hist_expire_dups_first
setopt hist_fcntl_lock
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt no_clobber
setopt print_exit_value
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home
setopt share_history

zstyle ':completion:*' menu select=2
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

if-cmd() ( if (( $+commands[$1] )); then exit 0; fi; exit 1; )
src() { test -f "$1" && source "$1"; }

export CLICOLOR="1"
export TZ="Europe/London"
export EDITOR="nvim"
export VISUAL="$EDITOR"

export GPG_TTY=$TTY

export AWS_CLI_AUTO_PROMPT=on-partial
export AWS_DEFAULT_REGION=us-east-1
export CUCUMBER_PUBLISH_QUIET=true
export GIT_EXTERNAL_DIFF='difft'
export GOBIN="$HOME/.local/bin"
export GOPATH="$HOME/Developer"

case $(uname); in
  Darwin) export HOMEBREW_PREFIX=$([[ "$(uname -m)" == 'arm64' ]] && echo "/opt/homebrew" || echo "/usr/local") ;;
   Linux) export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"; ;;
esac

test -x "$HOMEBREW_PREFIX/bin/brew" && eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

export MANPATH="$HOME/Developer/opt/share/man${MANPATH+:$MANPATH}:"
export XDG_DATA_DIRS="${HOMEBREW_PREFIX}/share:$XDG_DATA_DIRS"

path=(
  "$HOME/.local/bin"
  "$HOME/Developer/opt/bin"
  "$HOMEBREW_PREFIX/opt/curl/bin"
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  '/usr/local/bin'
  '/usr/local/sbin'
  '/usr/bin'
  '/usr/sbin'
  '/bin'
  '/sbin'
  $path
)

# Prevent duplicate PATH entries
typeset -U PATH path

# Remove dirs from PATH that don't exist
for ((i = 1; i <= $#path; i++)); do
  test ! -d "$path[i]" && path[i]=()
done

fpath=(
  "$HOME/.awsume/zsh-autocomplete"
  "$HOME/.local/share/zsh/functions"
  "${HOMEBREW_PREFIX}/share/zsh/site-functions"
  $fpath
)

autoload -Uz compinit && compinit
zmodload zsh/complist

# Prevent duplicate fpath entries
typeset -U fpath

# Remove dirs from PATH that don't exist
for ((i = 1; i <= $#fpath; i++)); do
  test ! -d "$fpath[i]" && fpath[i]=()
done

alias awsume="source awsume"
alias as=awsume
alias prune-symlinks='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'
alias k='ls'
alias vimdiff='nvim -d'
alias gron='fastgron'
alias ungron='fastgron --ungron'
alias wv_kid_to_uuid="base64 --decode | xxd -p | python -c 'import sys,uuid; print(uuid.UUID(hex=sys.stdin.readline().rstrip()))'"

alias tolower='tr "[:upper:]" "[:lower:]"'
alias toupper='tr "[:lower:]" "[:upper:]"'

fzy-history() {
  LBUFFER+=$(
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) \
    | fzy \
    | sed -E 's/ *[0-9]*\*? *//' \
    | sed -E 's/\\/\\\\/g'
  )
  zle reset-prompt
}
zle -N fzy-history
bindkey "^r" fzy-history

fzy-dir() {
  LBUFFER+=$(fd -t d -H | fzy)
  zle reset-prompt
}
zle -N fzy-dir
bindkey "^g" fzy-dir

fzy-file() {
  LBUFFER+=$(fd -t f -H | fzy)
  zle reset-prompt
}
zle -N fzy-file
bindkey "^t" fzy-file

fzy-commit() {
  LBUFFER+=$(git log --oneline | fzy | awk '{print $1}')
  zle reset-prompt
}
zle -N fzy-commit
bindkey "^g" fzy-commit

path()     ( echo "$PATH"     | tr : $'\n'; )
fpath()    ( echo "$FPATH"    | tr : $'\n'; )
infopath() ( echo "$INFOPATH" | tr : $'\n'; )
manpath()  ( echo "$MANPATH"  | tr : $'\n'; )

strip_tokenisation() ( awk '{gsub(/\?(akamai|fastly|bc)_token=[^"]+/, "")}1'; )

fkill() (
  kill $@ $(ps -eo pid,user,stat,command | fzy | awk '{print $1}')
)

repo() {
  URL=$1
  BASE=$(trurl -g '{host}{path}' "$URL" | cut -d '/' -f-2)
  DIR="$HOME/Developer/src/${BASE}"
  mkdir -p "$DIR"
  cd "$DIR"
  git clone --recursive "$(trurl --set scheme=https "${URL}")"
  cd "$(basename "$URL")"
}

mise-env() {
  export MISE_ENV=$@
}

# if-cmd starship && eval "$(starship init zsh)"
# unset RPS1

# if-cmd oh-my-posh && \
#   eval "$(oh-my-posh init zsh --config "$HOME/.config/oh-my-posh/config.omp.toml")"

if [ -n "${UPTERM_ADMIN_SOCKET:-}" ]; then
  export UPTERM_SYM='🤝'
fi

if-cmd zoxide && eval "$(zoxide init zsh)"
if-cmd mise   && eval "$(mise activate zsh)"
if-cmd sq     && source <(sq completion zsh)

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

src "$HOME/.config/op/plugins.sh"
src "$HOME/.localrc"

PROMPT="
%{$fg[green]%}#%{$reset_color%} "

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source "${HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

