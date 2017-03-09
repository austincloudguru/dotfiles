# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#

# Quick Function to get a shell on a docker container
dockershell() {
      docker exec -i -t $1 /bin/bash
}
dockerip() {
  docker inspect $1|jq -r .[0].NetworkSettings.Networks.docker_default.IPAddress

}
