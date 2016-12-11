# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
# Source the bash_prompt
if [ -f ~/.bash_prompt ]
  then
    source ~/.bash_prompt
  fi

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
