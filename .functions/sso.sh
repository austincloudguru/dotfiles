#!/usr/bin/env bash

ssolp() {
  aws sso login --profile prod-security
  export AWS_ORG_ID="d-90676f2986"
}

ssold() {
  aws sso login --profile dev-security
  export AWS_ORG_ID="d-90676f2986"
}

ssot() {
  export ACCESS_TOKEN=$(grep -h $AWS_ORG_ID ~/.aws/sso/cache/*.json*.json |jq -r .accessToken)
}

ssop() {
  if [[ -z $1 ]]; then
    unset AWS_PROFILE unset AWS_CREDS_EXPIRE
    unset AWS_SDK_LOAD_CONFIG
    unset AWS_ORG_ID
  else
    export AWS_CREDS_EXPIRE=$(grep -h $AWS_ORG_ID ~/.aws/sso/cache/*.json |jq -r .expiresAt) 
    export AWS_PROFILE=$1
  fi
}
