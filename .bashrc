# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
# Create the Prompt
case "$OSTYPE" in
  darwin*)
    export PS1="\$(git_prompt)(\[\033[32m\]\[\] \h:\[\033[36;1m\]\w\[\033[m\]) \n% "
    ;;
  *)
    export PS1="\$(git_prompt)(\[\033[32m\] \h:\[\033[36;1m\]\w\[\033[m\]) \n% "
    ;;
esac

# Source the functions directory
if [ -d ~/.functions ]; then
    for F in ~/.functions/*; do
        source $F
    done
fi

# Source the bash_secret file
if [ -f ~/.bash_secret ]; then
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

# Turn on AWS autocomplete
complete -C '/usr/local/bin/aws_completer' aws

# VirtualEnv Wrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  export PIP_REQUIRE_VIRTUALENV=true
  export WORKON_HOME=~/.virtualenvs
  source /usr/local/bin/virtualenvwrapper.sh
fi

if [[ -n $AWS_VAULT ]]; then
  export PS1="\[\e[33;38m\](aws-vault: $AWS_VAULT)\n\[\e[0m\]$PS1"
  workon aws
fi
