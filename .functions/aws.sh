# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash

# Get the Account Number
getaccount() {
  aws sts get-caller-identity \
    --query "Account" --output text
}

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
  opon
  aws-vault exec -t 4h --assume-role-ttl=1h -m $(getmfa "AWS - acg-awsmaster") acgm
}

# Log into acg-aws1 AWS Account
acg1() {
  opon
  aws-vault exec -t 4h --assume-role-ttl=1h -m $(getmfa "AWS - acg-awsmaster") acg1
}

# Log into acg-aws2 AWS Account
acg2() {
  opon
  aws-vault exec -t 4h --assume-role-ttl=1h -m $(getmfa "AWS - acg-awsmaster") acg2
}

# Log into acg-monitoring AWS Account
acgmon() {
  opon
  aws-vault exec -t 4h --assume-role-ttl=1h -m $(getmfa "AWS - acg-awsmaster") acgmon
}

# Log into acg accounts
acg() {
  opon
  aws-vault exec -t 4h --assume-role-ttl=1h -m $(getmfa "aws-acg-master") acg-$1

}
