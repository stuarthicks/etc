# vi: set ft=zsh

PROFILE_STARTUP=${PROFILE_STARTUP:-false}
if [[ "$PROFILE_STARTUP" == true ]]; then
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>$HOME/tmp/startlog.$$
    setopt xtrace prompt_subst
fi

. "$HOME/.functions"
. "$HOME/.aliases"

export TERM='screen-256color'
export TZ='Europe/London'
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

export PAGER=less
export VISUAL=nvim
export EDITOR="$VISUAL"

export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export REPORTTIME=1
export KEYTIMEOUT=1
export COMPLETION_WAITING_DOTS="true"

export AWS_CONFIG_DIR="$HOME/.aws"

export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"

export HOMEBREW_NO_ANALYTICS=1

# gpg-agent --daemon --write-env-file "$HOME/.gpg-agent-info"
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPGKEY=B7CCA53C
  export GPG_AGENT_INFO
  export GPG_TTY="$(tty)"
fi

export SSH_ENV="$HOME/.ssh/environment"
if [ -f "${SSH_ENV}" ]; then source "${SSH_ENV}" > /dev/null 2>&1; fi
