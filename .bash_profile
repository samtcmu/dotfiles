# name Sat May 28 23:46:03 PDT 2011
# title: .bash_profile
# date created: Mon Jan 19 15:45:04 EST 2009
# description: Configuration file for my bash shell.

# last modified: Sat May 28 23:51:17 PDT 2011

export PATH='/opt/local/bin:/opt/local/sbin:/Users/samt/config/scripts/bin':$PATH
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

# Set up alias commands for simics.
alias andrew='ssh stetruas@unix.andrew.cmu.edu'
alias andrewx='ssh -X stetruas@unix.andrew.cmu.edu'
alias atemi='ssh samt@atemi.cdm.cs.cmu.edu'
alias atemix='ssh -X samt@atemi.cdm.cs.cmu.edu'
alias andrew_login='klog stetruas@andrew.cmu.edu'
alias math='rlwrap /Applications/Mathematica.app/Contents/MacOS/MathKernel'
alias sml='rlwrap sml'
alias sed='gsed'
alias grep='grep --color'
alias objdump='gobjdump'

source ~/config/scripts/bin/git-prompt.sh

