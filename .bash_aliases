# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
if [ -f /usr/local/bin/hub ]
then
  alias git='hub'
fi

alias agr='ansible-galaxy install -r requirements.yml'
alias agrf='ansible-galaxy install -r requirements.yml --force'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias oplogin='eval $(op signin marsdominion)'
alias opauth='op get totp "AWS - WPE Users"'
alias opmars='op get totp "AWS - marsdominion"'
alias avmars='aws-vault exec -m $(opmars) marsdominion'
alias avauth='aws-vault exec -m $(opauth) auth'
alias av='aws-vault'
alias avl='aws-vault list'
alias od='~/.odrive/bin/[????]/odrive.py'
