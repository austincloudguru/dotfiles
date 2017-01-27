# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
# Create the Prompt
case "$OSTYPE" in
  darwin*)
    export PS1="(\[\033[32m\]\[\] \h:\[\033[36;1m\]\w\[\033[m\]) \n% "
    ;;
  *)
    export PS1="(\[\033[32m\] \h:\[\033[36;1m\]\w\[\033[m\]) \n% "
    ;;
esac

# Source the bash_functions
if [ -f ~/.bash_functions ]
  then
    source ~/.bash_functions
  fi

# Source the bash_aliases file
if [ -f ~/.bash_aliases ]
  then
    source ~/.bash_aliases
  fi

# Source the bash_secret file
if [ -f ~/.bash_secret ]
  then
    source ~/.bash_secret
  fi

# Set vi as the editor
set -o vi
export EDITOR=vi

# Colors for MAC
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
  export CLICOLOR=1
  export LSCOLORS=GxBxhxDxfxhxhxhxhxcxcx
fi

# set the path to include the sbin directories
export PATH=/usr/sbin:/sbin:/Users/mark.honomichl/bin:$PATH
export PATH=/usr/local/bin:$PATH
