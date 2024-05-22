# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#

# OS Specific Config
case "$OSTYPE" in
  darwin*)
    export SYSTEM_ICON=""
    # GPG for SSH
    export "GPG_TTY=$(tty)"
    export "SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh"
    # Turn on AWS autocomplete
    if [ -f  /usr/local/share/zsh/site-functions/aws_zsh_completer.sh ]; then
      autoload -Uz compinit
      compinit
      source /usr/local/share/zsh/site-functions/aws_zsh_completer.sh       
    fi
    # CLI Color Scheme
    export CLICOLOR=1
    export LSCOLORS=GxBxhxDxfxhxhxhxhxcxcx # Dark
    ;;
  *)
    export SYSTEM_ICON="🐧"
    # export GPG_TTY="$(tty)"                                                         
    # export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)                    
    # gpgconf --launch gpg-agent  
    ;;
esac

# Setup Prompt
autoload -U colors && colors
setopt PROMPT_SUBST
PS1='$(s2aprompt)$(git_prompt)(%{$fg[green]%}$SYSTEM_ICON %m: %{$reset_color%}%{$fg[blue]%}%~%{$reset_color%})
%# '

# Set vi as the editor
bindkey -v

# Source the functions directory
if [ -d ~/.functions ]; then
    for F in ~/.functions/*; do
        source $F
    done
fi

# set the path to include the sbin directories
export PATH=/usr/sbin:/sbin:/Users/mark.honomichl/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

# VirtualEnv Wrapper
if [ -f /opt/homebrew/bin/virtualenvwrapper.sh ]; then
  export VIRTUALENVWRAPPER_PYTHON=`which python3`
  export VIRTUALENV_PYTHON=`which python3`
  export PIP_REQUIRE_VIRTUALENV=true
  export WORKON_HOME=~/.virtualenvs
  source /opt/homebrew/bin/virtualenvwrapper.sh
fi

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
if [ -d ~/.rbenv ]; then
  export PATH=~/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

export VAULT_ADDR=https://vault.cicd.cloud.fpdev.io:8200

export PATH="$PATH:$HOME/.rvm/bin"
