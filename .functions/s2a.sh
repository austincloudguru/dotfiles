#!/usr/bin/env bash

s2aprompt() {
  if [[ -v AWS_PROFILE ]]; then
    CYAN="$(tput setaf 6)"
    RESET=$(tput sgr0)
    printf "$CYAN(saml2aws: $AWS_PROFILE)\n$RESET"
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
  else
    export AWS_PROFILE=$1
  fi
}
