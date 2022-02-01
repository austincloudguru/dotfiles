#!/usr/bin/env bash

ssol() {
  aws sso login
}

ssot() {
  export ACCESS_TOKEN=$(cat ~/.aws/sso/cache/d3841c25167f4e2f8e9c3eb450567fbcc2a64510.json|jq -r .accessToken)
}

ssop() {
  if [[ -z $1 ]]; then
    unset AWS_PROFILE unset AWS_CREDS_EXPIRE
    unset AWS_SDK_LOAD_CONFIG
  else
    export AWS_CREDS_EXPIRE=$(cat ~/.aws/sso/cache/d3841c25167f4e2f8e9c3eb450567fbcc2a64510.json|jq -r .expiresAt)
    export AWS_PROFILE=$1
  fi
}
