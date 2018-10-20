# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#

# Alias the git command to hub if it exists
if [ -f /usr/local/bin/hub ]
then
  alias git='hub'
fi

# odrive sync tool
if [ -d ~/.odrive/bin ]; then
   OD_VERSION=$(ls ~/.odrive/bin)
  alias od='~/.odrive/bin/${OD_VERSION}/odrive.py'
fi

# Alias to get my current IP Address
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

# Alias for tmuxinator
alias mux='tmuxinator'

