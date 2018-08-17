# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
if [ -f /usr/local/bin/hub ]
then
  alias git='hub'
fi

# Alias to get my current IP Address
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

# Alias for tmuxinator
alias mux='tmuxinator'

# 1Password CLI shortcuts
alias oplogin='eval $(op signin marsdominion)'
alias opauth='op get totp "AWS - WPE Users"'
alias opwpm='op get totp "AWS - WPE Master"'
alias opmars='op get totp "AWS - marsdominion"'

# aws-vault aliases
alias av='aws-vault'
alias avl='aws-vault list'
alias avmars='aws-vault exec -m $(opmars) marsdominion'
alias avauth='aws-vault exec -m $(opauth) auth'

# Ansible Galaxy aliases
alias agr='ansible-galaxy install -r requirements.yml'
alias agrf='ansible-galaxy install -r requirements.yml --force'

# odrive sync tool
if [ -d ~/.odrive/bin ]; then
   $OD_VERSION=$(ls ~/.odrive/bin)
  alias od='~/.odrive/bin/${OD_VERSION}/odrive.py'
fi
