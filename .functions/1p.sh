# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash

opsignin() {
  if [[ -z $OP_SESSION_marsdominion ]]; then
    eval $(op signin marsdominion)
  fi
}

opsignout() {
  unset OP_SESSION_marsdominion
}

sshkey() {
  opsignin
  echo "$(op get item "acg-master" |jq -r '.details.notesPlain')"|ssh-add -
  opsignout
}

gittoken() {
  opsignin
  GIT_TOKEN=$(op get item "GitHub"|jq -r '.details.sections[] | select(.fields).fields[] | select(.t== "Personal Laptop").v')
  opsignout
}
