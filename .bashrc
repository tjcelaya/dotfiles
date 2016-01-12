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

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

currentgitbranch() { if [[ -d .git ]]; then echo -n "($(git rev-parse --abbrev-ref HEAD 2> /dev/null))"; fi }

if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
    export PS1="\n\!\[\033[01;32m\]\W\[\033[00m\] \t \[\033[32m\]\$(currentgitbranch)\[\033[00m\]\n    ∴ "

else
    export PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
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

git config --global user.name "Tomas Celaya"
git config --global user.email tjcelaya@gmail.com

git config --global alias.co checkout
git config --global alias.s status

git config --global color.ui true


export PAGER=less
export PATH=~/bin:$PATH

PS1='\u \!\[\033[01;32m\]\W\[\033[00m\] \$ '

alias a='alias'
alias c='clear'
alias less='less -r '
alias gS='git status -s '
alias gD='git diff '
alias hgrep='history | grep '
alias ebrc='vim ~/.bashrc && source ~/.bashrc'
alias buns='bundle install'
alias fartisan='php artisan '

noisily () { "$@" && (aplay -q ~/bin/smw_powerup.wav &) || (aplay -q ~/bin/smw_death.wav &); }

alias n='noisily '
alias gd-n='g diff --name-only'

alias ll='ls -lhaF'
alias la='ls -lhaF'
alias l='ls -lhaF'

alias g='git '

## OS X
# defaults write -g ApplePressAndHoldEnabled -bool false

function pffwd() {
  echo "rdr pass inet proto tcp from any to any port $1 -> 127.0.0.1 port $2" | sudo pfctl -ef - >/dev/null 2>&1;
  echo "Add Port Forwarding ($1 => $2)"
}

function gitprompt() {
 if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
   echo -en "(\033[01;32m" $(git branch 2> /dev/null | egrep '^\*(.*)' | sed 's/\* //') "\033[00m) ";
   git diff --quiet >/dev/null 2>&1 && echo -en '\033[01;32m✔\033[00m' || echo -en '\033[01;31m✘\033[00m';
 fi
}

GREEN='\[\033[01;32m\]'
YELLO='\[\033[01;33m\]'
BLUE='\[\033[01;34m\]'
RED=$(tput setaf 1)
ULINE=$(tput smul)
NLINE=$(tput rmul)
BASE='\[\033[00m\]'
DATEFMT="+\"%Z %H:%M\""
PS1="\n\$?$GREEN \W$BASE \u@$BLUE\H$YELLO $ULINE\$(date ${DATEFMT})${NLINE} ${RED}${ULINE}\$(TZ='UTC' date +\"%Z %H:%M\")${NLINE}${BASE} \$( gitprompt )  \n  λ "

if [ -f ~/git-completion.bash ]; then
  source ~/git-completion.bash
  __git_complete g __git_main
fi

if hash rbenv 2>/dev/null; then
  eval "$(rbenv init -)"
fi

if [ -d ~/.rvm ]; then
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi

if [ -f ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi

bind Space:magic-space

function aa() {
  # ALIAS=$1; shift
  # CMD=$*
  # echo "alias $ALIAS='$CMD '"
  echo "alias $1='${@:2} '" >> ~/.bashrc && source .bashrc
}
alias gcd1='git clone --depth=1 '
