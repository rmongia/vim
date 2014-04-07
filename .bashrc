# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
# Set the bash history size.
export HISTSIZE=10000

export TERM="xterm-256color"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_colored_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=yes
    fi
fi
color_prompt=yes
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi


# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export TOP="/home/beehive"
#export EDITOR="emacs -nw"
export EDITOR=vim
export SVN_TEMPLATE_PATH=$TOP/svn.template.txt
export SVN_EDITOR=$TOP/edit-with-svn-template.sh

alias meldon='export GIT_EXTERNAL_DIFF=/usr/local/bin/ext-get-diff.sh'
alias meldoff='unset GIT_EXTERNAL_DIFF'

export PATH=$HOME/usr/bin:$HOME/usr/local/bin:$PATH
#export PKG_CONFIG_PATH=$HOME/usr/lib/pkgconfig
alias rnl="sed 's/\\\\n/\n/g'"
alias ipy="python `which ipython`"
alias g="grep --color=always"
alias l="less -R"
alias sec="vim /media/A850B93250B90858/DATA/Personal/Documents/Secret.vim"
alias pg="\ps -ef | grep --color=always"
alias ps="\ps -o pid,user,pcpu,pmem,rss,cputime,cmd"
alias ll="ls -ltr"
export INSTART_ROOT=~/
export BUILD_ROOT=$INSTART_ROOT/kido/build
alias bl="cd $BUILD_ROOT"
export VIEW_ROOT=$HOME/kido
function rpt()
{
    i=0
    ret=0
    while [ $ret -eq 0 ];do $@;ret=$?;echo $i;i=$(( i + 1));sleep 1;done
}

alias t="tail -f --follow=name --retry"
function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}

function rgit(){
  pwd=$PWD
  ssh -p 2222 localhost "cd $pwd && git $@"
}

function pr()
{
    people=$1
    shift
    branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`

    echo "Changes in feature and not in master"
    git log  master..$branch --oneline | awk '{print NR") "$0}'
    NR=1
    echo -n "Enter the base version from which to include the review. [Default $NR]: "
    read diff
    NR=${diff:=$NR}
    git log --name-status -$NR --oneline
    parent_sha1=`git log -$((NR + 1 )) --pretty=format:%H | tail -1`
    if [ -z "$people" ]
    then
      echo -n "Please enter the comma seperated ids of people you want to send this for review: "
      read people
    fi

    echo "Sending review request to $people [Any key to continue]"
    cmd="post-review -p --parent=$parent_sha1 --target-people=$people --target-groups=dev --guess-description --guess-summary $@"
    echo $cmd
    read
    $cmd
}

function s()
{
  ssh root@$@
}
function r()
{
  ssh readonly@$@
}



export PROJECT=Instart
alias ..="cd .."

function pgdb()
{
    gdb -p `pgrep $1 | tail -1`
}


export REPO_ROOT=$INSTART_ROOT/kido

# id_list=`ssh-add -l | gawk -F" " '{print $3}'`
# add_id="$HOME/.ssh/id_dsa"
# if [ $id_list != $add_id ]
#   then
#   ssh-add $HOME/.ssh/id_dsa
# fi

