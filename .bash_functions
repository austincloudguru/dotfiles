# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#

# Quick Function to get a shell on a docker container
dockershell() {
      docker exec -i -t $1 /bin/bash
}
dockerip() {
  docker inspect $1|jq -r .[0].NetworkSettings.Networks.docker_default.IPAddress

}
ec2ip() {
  aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value|[0],PrivateIpAddress]" --output text
}
ec2list() {
aws ec2 describe-instances --query "Reservations[*].Instances[*].[PrivateIpAddress, Tags[?Key=='Name'].Value|[0]]" --output table
}
