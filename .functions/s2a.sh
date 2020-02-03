#!/usr/bin/env bash

s2aprompt() {
  if [[ -v AWS_PROFILE ]]; then
    CYAN="$(tput setaf 6)"
    RESET=$(tput sgr0)
    printf "$CYAN(saml2aws: $AWS_PROFILE expires: $AWS_CREDS_EXPIRE)\n$RESET"
  fi
}

s2al() {
  if [[ $1 == "gov-west" ]]; then
    export AWS_DEFAULT_REGION=us-gov-west-1
    gimme-aws-creds
  else 
    saml2aws login -a $1
  fi
}

s2a() {
  saml2aws exec -a $1 /bin/zsh
}

s2ap() {
  if [[ -z $1 ]]; then
    unset AWS_PROFILE unset AWS_CREDS_EXPIRE
    unset AWS_SDK_LOAD_CONFIG
  else
    subaccounts=(acg-dev acg-shared acg-prod)
    if [[ ${subaccounts[(ie)$1]} -le ${#subaccounts} ]]; then
      master_account="acg-master"
      export AWS_SDK_LOAD_CONFIG=1
    else
      master_account=$1
    fi
    export AWS_CREDS_EXPIRE=$(python3 - "$master_account" << END
import configparser
import sys
cred_file = "/Users/mark.honomichl/.aws/credentials"
account = sys.argv[1]
config = configparser.ConfigParser()
config.sections()
config.read(cred_file)
try:
  expire_string = config[account]['x_security_token_expires']
  print(expire_string[11:19])
except KeyError:
  print("unset")
END
)

    if [[ $AWS_CREDS_EXPIRE == "unset" && $master_account != "gov-west" ]];then
      #if [[ $master_account == "gc-shared" ]];then
      echo "Profile doesn't exist! \n"
      unset AWS_CREDS_EXPIRE
    else
      export AWS_PROFILE=$1
    fi
  fi
}
