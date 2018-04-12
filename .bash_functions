# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#

# Run mac-playbook
updatemac() {
  unset PIP_REQUIRE_VIRTUALENV
  cd ~/macbook-ansible/mac-playbook
  ansible-playbook playbook.yml -i inventory -K
  export PIP_REQUIRE_VIRTUALENV=true
}

# Quick Function to get a shell on a docker container
dockershell() {
      docker exec -i -t $1 /bin/bash
}
dockerip() {
  docker inspect $1|jq -r .[0].NetworkSettings.Networks.docker_default.IPAddress

}
dockerlogin() {
	aws ecr get-login --profile sre_devcloud --region us-east-1 --no-include-email
	#aws ecr get-login --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION --no-include-email
}
setaws() {
  export AWS_PROFILE=$1
}

setregion() {
  export AWS_DEFAULT_REGION=$1
}

ec2ssh() {
  read IP KEY <<< $(aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --query "Reservations[*].Instances[*].[PrivateIpAddress, KeyName]" --output text)

  ssh -i ~/.ssh/$KEY $2@$IP
}

ec2info() {
  aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value|[0],PrivateIpAddress, KeyName]" --output table
}

ec2list() {
  aws ec2 describe-instances --query "Reservations[*].Instances[*].[PrivateIpAddress, Tags[?Key=='Name'].Value|[0]]" --output table
}

rdslist() {
  aws rds describe-db-instances --query "DBInstances[*].[DBInstanceIdentifier, Engine]" --output table
}

rdsinfo() {
  aws rds describe-db-instances --filters "Name=db-instance-id,Values=$1" --query "DBInstances[*].[DBInstanceIdentifier, Engine, Endpoint.Port, Endpoint.Address]" --output table
}

awsid() {
AWS_PROFILE=$1 aws sts get-caller-identity --query "Account" --output text
}

checktags() {
aws ec2 describe-instances --filters "Name=instance-state-name, Values=running" --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value|[0], Tags[?Key=='division'].Value|[0], Tags[?Key=='project'].Value|[0], Tags[?Key=='environment'].Value|[0]]" --output table
}

sshi() {
  ssh -i ~/.ssh/$1 $2
}

# One Password CLI commands
opcreds() {
  op get item "$1"| jq -r  '.details.fields[] | select(.designation=="username").value, select(.designation=="password").value'
}

oplist() {
  op list items|jq -r '.[].overview.title'
}

# aws-vault commands
avr() {
  aws-vault remove -s $1
}

avmm() {
  aws-vault exec -m $(opauth) $1
}
