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

# Get the local IP of a docker container
f_arr[2]="dockerip \$container:Get the IP of a local Docker container"
dockerip() {
  docker inspect $1|jq -r .[0].NetworkSettings.Networks.$1_default.IPAddress

}

# Set the AWS Region
f_arr[3]="setregion \$container:Set the AWS Region"
setregion() {
  export AWS_DEFAULT_REGION=$1
}

# SSH to an EC2 instance
f_arr[4]="ec2ssh \$TagName \$ssh-key:SSH to an EC2 Instance"
ec2ssh() {
  read IP KEY <<< $(aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --query "Reservations[*].Instances[*].[PrivateIpAddress, KeyName]" --output text)

  ssh -i ~/.ssh/$KEY $2@$IP
}

# List EC2 details
f_arr[5]="ec2info \$TagName:List details of an EC2 instance"
ec2info() {
  aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value|[0],PrivateIpAddress, KeyName]" --output table
}

# List EC2 instances
f_arr[6]="ec2list:List EC2 instances"
ec2list() {
  aws ec2 describe-instances --query "Reservations[*].Instances[*].[PrivateIpAddress, Tags[?Key=='Name'].Value|[0]]" --output table
}

# List RDS instances
f_arr[7]="ec2list:List RDS instances"
rdslist() {
  aws rds describe-db-instances --query "DBInstances[*].[DBInstanceIdentifier, Engine]" --output table
}

# List RDS details
f_arr[8]="rdsinfo \$TagName:List details of an RDS instance"
rdsinfo() {
  aws rds describe-db-instances --filters "Name=db-instance-id,Values=$1" --query "DBInstances[*].[DBInstanceIdentifier, Engine, Endpoint.Port, Endpoint.Address]" --output table
}

# Get the AWS Account ID 
f_arr[9]="awsid $account:Get the AWS id of a Macmillan Account"
awsid() {
aws-vault exec -m $(opauth) $1 -- aws sts get-caller-identity --query "Account" --output text
}

# SSH with a key
f_arr[10]="sshi \$ssh-key \$system:SSH with key"
sshi() {
  ssh -i ~/.ssh/$1 $2
}

# One Password CLI commands
f_arr[11]="opcreds \$item:get credentials from one password"
opcreds() {
  op get item "$1"| jq -r  '.details.fields[] | select(.designation=="username").value, select(.designation=="password").value'
}

# List 1Password Credentials
f_arr[12]="oplists:List 1Password Credentials"
oplist() {
  op list items|jq -r '.[].overview.title'
}

# aws-vault commands
f_arr[13]="avr:Remove a session from aws-vault"
avr() {
  aws-vault remove -s $1
}

# Log into a WPEngine AWS Account using aws-vault
f_arr[14]="avmm:Log into a WP Engine AWS Account w/ aws-vault"
avwp() {
  if [[ -z $OP_SESSION_marsdominion ]]; then
   eval $(op signin marsdominion) 
  fi
  aws-vault exec --assume-role-ttl=1h -m $(opauth) $1
  unset OP_SESSION_marsdominion
}

# Get a Vault Token
f_arr[15]="vtoken:Get a Token from Vault"
vtoken() {
  export VAULT_TOKEN=$(curl -sk $VAULT_ADDR/v1/auth/github/login -d '{ "token": "'${GIT_TOKEN}'" }'|jq  -r .auth.client_token)
}

# Log into a acg account
f_arr[16]="avacg:Log into a aws-acgX AWS Account w/ aws-vault"
avacg() {
  if [[ -z $OP_SESSION_marsdominion ]]; then
   eval $(op signin marsdominion)
  fi
  aws-vault exec -m $(op get totp "AWS - acg-aws1") acg-aws1
  unset OP_SESSION_marsdominion
}

# Log into a WPEngine Master AWS Account using aws-vault
f_arr[17]="avwpm:Log into a WP Engine Master AWS Account w/ aws-vault"
avmaster() {
  if [[ -z $OP_SESSION_marsdominion ]]; then
   eval $(op signin marsdominion) 
  fi
  aws-vault exec --assume-role-ttl=1h -m $(opwpm) master
  unset OP_SESSION_marsdominion
}

functions() {
  for i in "${f_arr[@]}"
  do
    A=`cut -d: -f1 <<< "$i"`
    B=`cut -d: -f2 <<< "$i"`
    printf "%-25s |  %s\n" "$A" "$B";
  done
}
