# name Sat May 28 23:46:03 PDT 2011
# title: .bash_profile
# date created: Mon Jan 19 15:45:04 EST 2009
# description: Configuration file for my bash shell.

# last modified: Mon Sep 12 13:23:42 EDT 2011

export PATH='/opt/local/bin:/opt/local/sbin:/Users/${USER}/config/scripts/bin':$PATH
export CLASSPATH='/opt/local/var/macports/software/weka/3.6.1_0/Applications/MacPorts/Weka.app/Contents/Resources/Java/weka.jar':$CLASSPATH
export MANPATH='/opt/local/share/man':$MANPATH
export ZAZU='/Volumes/zazu'
export POOH='/Volumes/pooh'
export GOPHER='/Volumes/gopher'
export CMU='/Users/samt/private/cmu/term7'
export CDMWWW='/afs/andrew.cmu.edu/course/15/354/www'
export ANDREW='/afs/andrew.cmu.edu/usr23/stetruas'
export CPU_WWW='/Library/WebServer/'

export GALILEO='galileo.redmond.corp.microsoft.com'

export EDITOR='vim'

# Set up alias commands for simics.
alias andrew='ssh stetruas@unix.andrew.cmu.edu'
alias andrewx='ssh -X stetruas@unix.andrew.cmu.edu'
alias atemi='ssh samt@atemi.cdm.cs.cmu.edu'
alias atemix='ssh -X samt@atemi.cdm.cs.cmu.edu'
alias google='ssh samtet@samtet.nyc.corp.google.com'
alias googlex='ssh -X samtet@samtet.nyc.corp.google.com'
alias andrew_login='klog stetruas@andrew.cmu.edu'
alias math='rlwrap /Applications/Mathematica.app/Contents/MacOS/MathKernel'
alias sml='rlwrap sml'
alias sed='gsed'
alias grep='grep -H -n -r --color'
alias objdump='gobjdump'

source ~/config/scripts/bin/git-prompt.sh

HISTSIZE=1000000
HISTFILESIZE=2000000

# Allow for shared history amongst all open terminal sessions.
# See http://stackoverflow.com/questions/103944/real-time-history-export-amongst-bash-terminal-windows
# for more information.
function bash_history_sync() {
    builtin history -a
    HISTFILESIZE=$HISTFILESIZE
    builtin history -c
    builtin history -r
}

function history() {
    bash_history_sync
    builtin history "$@"
}

function prompt_func() {
    git_prompt_func
    bash_history_sync
}

PROMPT_COMMAND=prompt_func

# Set custom key-bindings.
bind -f ~/config/dotfiles/.bash_key_bindings

