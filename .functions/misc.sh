# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash

# Alias to get my current IP Address
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

# Resource profiles
alias resource='source ~/.zshrc'


if [[ "$OSTYPE" == "darwin"* ]]; then
  # Alias for tmuxinator
  alias mux='$(which tmuxinator)'
else
  alias mux='/usr/local/bin/tmuxinator'
fi

alias muxssh='tmux setenv SSH_AUTH_SOCK $SSH_AUTH_SOCK'
