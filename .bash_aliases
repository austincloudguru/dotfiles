# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
if [ -f /usr/local/bin/hub ]
then
  alias git='hub'
fi

alias agr='ansible-galaxy install -r requirements.yml'
alias agrf='ansible-galaxy install -r requirements.yml --force'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
