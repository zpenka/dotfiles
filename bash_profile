#!/bin/bash

export GOPATH=$HOME/go
export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH=$PATH:~/bin:/usr/local/bin/heroku:$GOPATH/bin:/usr/local/sbin
export EDITOR=/usr/bin/vim

# Turn on 256 colors
if [ "$TERM" = "xterm" ]
then
  export TERM="xterm-256color"
fi

# Git tab completion
if test -f "~/.git-tab-completion"; then source ~/.git-tab-completion; fi

set -o vi  # use vi mode
bind -m vi-insert "\C-l":clear-screen # unbreak control+l in vi mode

export HISTFILESIZE=3000
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:exit:c:clear:ll:history:mixer:camus:cmus:~"
alias hist='history | grep $1' # search history

# Implied flags
alias vi='vim'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -alFh'
alias less='less -FSRXc'
alias rsync='rsync --progress'
alias jobs='jobs -l'
alias ping='ping -c 5'
alias wget='wget -c'
alias grep='grep --color=auto'
alias sockets='sudo lsof -i -P'
alias ports='netstat -tulanp'

# Laziness
alias ~='cd ~'
alias ..='cd ../'
alias cdgit='cd ~/Git'
alias dotfiles='cd ~/Git/dotfiles'
alias calc='bc -l'

alias camus='cmus' # For the truly absurd

# Docker
alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)' # Clean up all dangling images
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)' # Remove stopped containers
alias docker_clean_all='docker system prune --volumes -f' # Nuclear option. clean everything

# Identify highest usage processes
alias topmem='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
alias topcpu='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

# List the largest files in current directory
function largest() {
  find ${1:-.} -type f -exec ls -al {} \; | sort -nr -k5 | head -n 20
}

# Generate a random string of characters
function strgen() {
  local length="${1:-24}"
  LC_CTYPE=C tr -dc 'A-Za-z0-9_' < /dev/urandom | head -c ${length} | xargs
}

# Conduct a speed test
function speedtest() {
  local realm="${1:-useast}"

  case $realm in
    'useast')     location='http://speedtest.newark.linode.com/100MB-newark.bin'        ;;
    'uswest')     location='http://speedtest.fremont.linode.com/100MB-fremont.bin'      ;;
    'ussouth')    location='http://speedtest.atlanta.linode.com/100MB-atlanta.bin'      ;;
    'uscentral')  location='http://speedtest.dallas.linode.com/100MB-dallas.bin'        ;;
    'de')         location='http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin'  ;;
    'uk')         location='http://speedtest.london.linode.com/100MB-london.bin'        ;;
    'sg')         location='http://speedtest.singapore.linode.com/100MB-singapore.bin'  ;;
    'ja')         location='http://speedtest.tokyo.linode.com/100MB-tokyo.bin'          ;;
    *)            location=$1                                                           ;;
  esac

  wget --output-document=/dev/null $location
}

# Source local bash_profile file
source ~/.bash_profile-local

#
# bash-prompt
#
# Improved bash prompt with support for Git.
# github.com/sblaurock/bash-prompt
# v1.1
# Changes to script by zpenka
#

# Define colors
COLOR_DEFAULT='\[\e[39m\]'
COLOR_RED='\[\e[31m\]'
COLOR_GREEN='\[\e[32m\]'
COLOR_YELLOW='\[\e[33m\]'
COLOR_BLUE='\[\e[34m\]'
COLOR_MAGENTA='\[\e[35m\]'
COLOR_CYAN='\[\e[36m\]'
COLOR_LIGHT_GRAY='\[\e[37m\]'
COLOR_GRAY='\[\e[90m\]'
COLOR_LIGHT_RED='\[\e[91m\]'
COLOR_LIGHT_GREEN='\[\e[92m\]'
COLOR_LIGHT_YELLOW='\[\e[93m\]'
COLOR_LIGHT_BLUE='\[\e[94m\]'
COLOR_LIGHT_MAGENTA='\[\e[95m\]'
COLOR_LIGHT_CYAN='\[\e[96m\]'
COLOR_WHITE='\[\e[97m\]'

# Options
SHOW_USERNAME=true
SHOW_HOSTNAME=true
  NAME_DIVIDER="@"
  USERNAME_COLOR=$COLOR_LIGHT_GREEN
  HOSTNAME_COLOR=$COLOR_LIGHT_GREEN
  NAME_DIVIDER_COLOR=$COLOR_LIGHT_CYAN
SHOW_CWD=true
  FULL_CWD=true
  CWD_COLOR=$COLOR_LIGHT_YELLOW
SHOW_GIT=true
  SHOW_GIT_DIRTY=true
    GIT_DIRTY_SYMBOL=" ┬─┬ノ( º _ ºノ) "
    GIT_DIRTY_COLOR=$COLOR_LIGHT_YELLOW
  WRAP_BRANCH=false
    WRAP_BRANCH_SYMBOLS="[]"
  GIT_COLOR=$COLOR_LIGHT_BLUE
SPACER=" > "
  SPACER_COLOR=$COLOR_LIGHT_GRAY
SYMBOL=" $ "
  SYMBOL_COLOR=$COLOR_WHITE

# Return the current Git branch name (or false)
function git_branch() {
  local branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

  if [ ! -z $branch ]; then
    echo $branch
  fi
}

# Are we in a Git repository?
function on_git() {
  if $(git rev-parse --is-inside-work-tree 2> /dev/null); then
    return 0
  fi

  return 1
}

# Is our Git branch dirty?
function git_dirty() {
  if $(git diff-index --quiet HEAD 2> /dev/null); then
    return 1
  fi

  return 0
}

# Set the spacer based on whether or not group is first to be displayed
firstItem=true
function get_spacer() {
  $firstItem && spacer='' || spacer="${SPACER_COLOR}${SPACER}${SPACER_COLOR}"

  firstItem=false
}

# Sets bash prompt based on the values defined within options
function set_ps1() {
  if $SHOW_USERNAME || $SHOW_HOSTNAME ; then
    get_spacer

    if $SHOW_USERNAME && $SHOW_HOSTNAME ; then
      local divider=${NAME_DIVIDER_COLOR}${NAME_DIVIDER}${COLOR_DEFAULT}
    fi

    if $SHOW_USERNAME ; then
      local username=${USERNAME_COLOR}"\u"${COLOR_DEFAULT}
    fi

    if $SHOW_HOSTNAME ; then
      local hostname=${HOSTNAME_COLOR}"\h"${COLOR_DEFAULT}
    fi

    local name=${spacer}${username}${divider}${hostname}
  fi

  if $SHOW_CWD ; then
    get_spacer

    $FULL_CWD && cwdType="\w" || cwdType="\${PWD#\${PWD%/*/*}}"

    local cwd=${spacer}${CWD_COLOR}${cwdType}${COLOR_DEFAULT}
  fi

  if $SHOW_GIT ; then
    get_spacer

    if $SHOW_GIT_DIRTY ; then
      local dirty=${GIT_DIRTY_COLOR}${GIT_DIRTY_SYMBOL}${COLOR_DEFAULT}
    fi

    if $WRAP_BRANCH ; then
      local git=" "${GIT_COLOR}${WRAP_BRANCH_SYMBOLS:0:1}"\$(git_branch)"${WRAP_BRANCH_SYMBOLS:1:2}${COLOR_DEFAULT}
    else
      local git=${spacer}${GIT_COLOR}"\$(git_branch)"${COLOR_DEFAULT}
    fi
  fi

  local symbol=${SYMBOL_COLOR}${SYMBOL}${COLOR_DEFAULT}

  echo "${name}${cwd}\$(on_git && echo \"${git}\"\$(git_dirty && echo \"${dirty}\"))${symbol}"
}

export PS1=$(set_ps1)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/zpenka/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/zpenka/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/zpenka/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/zpenka/Downloads/google-cloud-sdk/completion.bash.inc'; fi
