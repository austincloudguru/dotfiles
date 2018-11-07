# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash

# Set the AWS Region
setregion() {
  export AWS_DEFAULT_REGION=$1
}

# Alias aws-vault
alias av='aws-vault'

# Alias aws-vault list
alias avl='aws-vault list'

# Remove an aws-vault session
avr() {
  aws-vault remove -s $1
}

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
