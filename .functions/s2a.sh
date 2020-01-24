#!/usr/bin/env bash

s2aprompt() {
  if [[ -v AWS_PROFILE ]]; then
    CYAN="$(tput setaf 6)"
    RESET=$(tput sgr0)
    printf "$CYAN(saml2aws: $AWS_PROFILE expires: $AWS_CREDS_EXPIRE)\n$RESET"
  fi
}

s2al() {
  saml2aws login -a $1
}

s2a() {
  saml2aws exec -a $1 /bin/zsh
}

s2ap() {
  if [[ -z $1 ]]; then
    unset AWS_PROFILE
    unset AWS_CREDS_EXPIRE
  else
    export AWS_CREDS_EXPIRE=$(python3 - "$1" << END
import configparser
import sys
cred_file = "/Users/mark.honomichl/.aws/credentials"
account = sys.argv[1]
config = configparser.ConfigParser()
config.sections()
config.read(cred_file)
try:
  print(config[account]['x_security_token_expires'])
except KeyError:
  print("unset")
END
)

    if [[ $AWS_CREDS_EXPIRE == "unset" ]];then
      echo "Profile doesn't exist! \n"
      unset AWS_CREDS_EXPIRE
    else
      export AWS_PROFILE=$1
    fi
  fi
}
