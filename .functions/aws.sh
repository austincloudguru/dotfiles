# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash

# Alias aws-vault
alias av='aws-vault'

# Log into acg-awsmaster AWS Account
acgm() {
  if [[ -z $OP_SESSION_marsdominion ]]; then
   eval $(op signin marsdominion)
  fi
  aws-vault exec -m $(op get totp "AWS - acg-awsmaster") acg2
  unset OP_SESSION_marsdominion
}

# Log into acg-aws2 AWS Account
acg2() {
  if [[ -z $OP_SESSION_marsdominion ]]; then
   eval $(op signin marsdominion)
  fi
  aws-vault exec -m $(op get totp "AWS - acg-awsmaster") acg2
  unset OP_SESSION_marsdominion
}
