#!/bin/bash

export PATH=$PATH:~/bin:/usr/local/pulse
export EDITOR=/usr/bin/vim

# Turn on 256 colors
if [ "$TERM" = "xterm" ]
then
  export TERM="xterm-256color"
fi

# Initialize nvm
if test -f "/usr/share/nvm/init-nvm.sh"; then source /usr/share/nvm/init-nvm.sh; fi

# Git tab completion
if test -f "~/.git-tab-completion"; then source ~/.git-tab-completion; fi

set -o vi  # use vi mode
bind -m vi-insert "\C-l":clear-screen # unbreak control+l in vi mode

setxkbmap -option ctrl:nocaps # set caps lock to control

export HISTFILESIZE=3000
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:exit:c:clear:ll:history:mixer:camus:cmus:~"
alias hist='history | grep $1' # search history
shopt -s histappend # When the shell exits, append to the history file instead of overwriting it

# Implied flags
alias vi='vim'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -alFh --color=auto --time-style=long-iso'
alias less='less -FSRXc'
alias rsync='rsync --progress'
alias jobs='jobs -l'
alias ping='ping -c 5'
alias wget='wget -c'
alias grep='grep --color=auto'
alias headers='curl -I'
alias sockets='sudo lsof -i -P'
alias ports='netstat -tulanp'
alias mount='mount |column -t'

# Laziness
alias ~='cd ~'
alias ..='cd ../'
alias cdgit='cd ~/Git'
alias dotfiles='cd ~/Git/dotfiles'
alias calc='bc -l'

alias camus='cmus' # For the truly absurd

# Arch Linux
alias orphans='sudo pacman -Rns $(pacman -Qtdq)' # Removes orphaned packages and their config files

# i3
alias lock='i3lock -c 000000 -n'

# Monitor Management
alias lsingle='~/.screenlayout/single.sh' # Adjust display to just laptop screen
alias lwork='~/.screenlayout/work.sh' # Adjust display to work setup

alias wboth='~/.screenlayout/workstation-both.sh'
alias w4k='~/.screenlayout/workstation-4k.sh'
alias wdvi='~/.screenlayout/workstation-dvi.sh'

alias say='echo "$1" | espeak -s 120 -p -65 &> /dev/null' # say things
alias whisper='echo "$1" | espeak -v en+whisper -s 120 -p -65 &> /dev/null' # whisper things

# Docker
alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)' # Clean up all dangling images
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)' # Remove stopped containers

# Git
alias gim='vim $(git ls-files -m | grep -v "/build/") -p' # Open modified files tracked by Git in Vim
alias gitcm='git checkout master; git pull origin master; git branch --merged | grep -v "\*" | xargs -n 1 git branch -d' # Clean all Git branches that have been merged to master (clean merged)
alias gitss='git diff --stat=120,100 origin/master...HEAD "$@"' # Show Git status of current branch against master (start stat)
alias gitsd='git diff origin/master...HEAD "$@"' # Show Git diff of current branch against master (start diff)
alias gitbm='git checkout master; git pull origin master; git checkout -b "$@"' # Cut a branch from remote master (branch master)
alias gitcl='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit' # Colorful Git log (color log)

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

# Source local bashrc file
source ~/.bashrc-local

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


export NVM_DIR="/home/zpenka/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$HOME/.yarn/bin:$PATH"
