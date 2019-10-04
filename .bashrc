# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
# Create the Prompt
case "$OSTYPE" in
  darwin*)
    export PS1="\$(git_prompt)(\[\033[32m\]\[\] \h:\[\033[36;1m\]\w\[\033[m\]) \n% "
    # GPG for SSH
    export "GPG_TTY=$(tty)"
    export "SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh"
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
if [ -f $VIRTUAL_ENV/bin/aws_completer ]; then
  complete -C '$VIRTUAL_ENV/bin/aws_completer' aws
fi

# VirtualEnv Wrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  export VIRTUALENVWRAPPER_PYTHON=`which python3`
  export VIRTUALENV_PYTHON=`which python3`
  export PIP_REQUIRE_VIRTUALENV=true
  export WORKON_HOME=~/.virtualenvs
  source /usr/local/bin/virtualenvwrapper.sh
fi

if [[ -n $AWS_VAULT ]]; then
  export PS1="\[\e[38;5;82m\](aws-vault: $AWS_VAULT)\n\[\e[0m\]$PS1"
  if [[ -n $VIRTUAL_ENV ]]; then
    workon $(basename $VIRTUAL_ENV)
  fi
fi

if [[ -n $AWS_OKTA_PROFILE ]]; then
  export PS1="\[\e[38;5;82m\](aws-okta: $AWS_OKTA_PROFILE)\n\[\e[0m\]$PS1"
  if [[ -n $VIRTUAL_ENV ]]; then
    workon $(basename $VIRTUAL_ENV)
  fi
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

