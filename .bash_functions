# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
# Run mac-playbook
f_arr[0]="updatemac:Runs mac-playbook"
updatemac() {
  unset PIP_REQUIRE_VIRTUALENV
  cd ~/macbook-ansible/mac-playbook
  ansible-playbook playbook.yml -i inventory -K
  export PIP_REQUIRE_VIRTUALENV=true
}

# Quick Function to get a shell on a docker container
f_arr[1]="dockershell $1:Get a shell on a local docker container"
dockershell() {
      docker exec -i -t $1 /bin/bash
}

# Set the AWS Region
f_arr[2]="setregion \$container:Set the AWS Region"
setregion() {
  export AWS_DEFAULT_REGION=$1
}

# Get the AWS Account ID 
f_arr[3]="awsid $account:Get the AWS id of a Macmillan Account"
awsid() {
aws-vault exec -m $(opauth) $1 -- aws sts get-caller-identity --query "Account" --output text
}

# One Password CLI commands
f_arr[4]="opcreds \$item:get credentials from one password"
opcreds() {
  op get item "$1"| jq -r  '.details.fields[] | select(.designation=="username").value, select(.designation=="password").value'
}

# List 1Password Credentials
f_arr[5]="oplists:List 1Password Credentials"
oplist() {
  op list items|jq -r '.[].overview.title'
}

# aws-vault commands
f_arr[6]="avr:Remove a session from aws-vault"
avr() {
  aws-vault remove -s $1
}

# Log into a WPEngine AWS Account using aws-vault
f_arr[7]="avwp:Log into a WP Engine AWS Account w/ aws-vault"
avwp() {
  if [[ -z $OP_SESSION_marsdominion ]]; then
   eval $(op signin marsdominion) 
  fi
  aws-vault exec --assume-role-ttl=1h -m $(opauth) $1
  unset OP_SESSION_marsdominion
}

# Get a Vault Token
f_arr[8]="vtoken:Get a Token from Vault"
vtoken() {
  export VAULT_TOKEN=$(curl -sk $VAULT_ADDR/v1/auth/github/login -d '{ "token": "'${GIT_TOKEN}'" }'|jq  -r .auth.client_token)
}

# Log into a acg account
f_arr[9]="avacg:Log into a aws-acgX AWS Account w/ aws-vault"
avacg() {
  if [[ -z $OP_SESSION_marsdominion ]]; then
   eval $(op signin marsdominion)
  fi
  aws-vault exec -m $(op get totp "AWS - acg-aws1") acg-aws1
  unset OP_SESSION_marsdominion
}

# Log into a WPEngine Master AWS Account using aws-vault
f_arr[10]="avwpm:Log into a WP Engine Master AWS Account w/ aws-vault"
avmaster() {
  if [[ -z $OP_SESSION_marsdominion ]]; then
   eval $(op signin marsdominion) 
  fi
  aws-vault exec --assume-role-ttl=1h -m $(opwpm) master
  unset OP_SESSION_marsdominion
}

f_arr[11]="git_prompt:Outputs the branch and status for my prompt"
git_prompt() {
  RED=$(tput setaf 1)
  YELLOW="$(tput setaf 3)"
  GREEN="\033[0;32m"
  RESET=$(tput sgr0)
  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')

  if [ ! -z $BRANCH ]; then
    printf "$YELLOW($BRANCH"

    if [ ! -z "$(git status --short)" ]; then
      printf " ${RED}✗"
    else
      printf " ${GREEN}✔"
    fi

    printf "${YELLOW} )\n${RESET}"
  fi
}

functions() {
  for i in "${f_arr[@]}"
  do
    A=`cut -d: -f1 <<< "$i"`
    B=`cut -d: -f2 <<< "$i"`
    printf "%-25s |  %s\n" "$A" "$B";
  done
}
