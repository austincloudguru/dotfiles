# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#

# Create the Prompt
case "$OSTYPE" in
  darwin*)
    autoload -U colors && colors
    setopt PROMPT_SUBST
    PS1='$(git_prompt)(%{$fg[green]%} %m: %{$reset_color%}%{$fg[cyan]%}%~%{$reset_color%})
%# '
    # GPG for SSH
    export "GPG_TTY=$(tty)"
    export "SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh"
    ;;
  *)
    PS1='$(git_prompt)(%{$fg[green]%} %m: %{$reset_color%}%{$fg[cyan]%}%~%{$reset_color%})
%# '
    ;;
esac

# Set vi as the editor
bindkey -v

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
  export CLICOLOR=1
  export LSCOLORS=GxBxhxDxfxhxhxhxhxcxcx
fi

# Source the functions directory
if [ -d ~/.functions ]; then
    for F in ~/.functions/*; do
        source $F
    done
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
  export PS1="%{$fg[yellow]%}(aws-okta: $AWS_VAULT)%{$reset_color%}
$PS1"
  if [[ -n $VIRTUAL_ENV ]]; then
    workon $(basename $VIRTUAL_ENV)
  fi
fi

if [[ -n $AWS_OKTA_PROFILE ]]; then
  export PS1="%{$fg[yellow]%}(aws-okta: $AWS_OKTA_PROFILE)%{$reset_color%}
$PS1"
  if [[ -n $VIRTUAL_ENV ]]; then
    workon $(basename $VIRTUAL_ENV)
  fi
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
