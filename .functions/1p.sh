# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash
gittoken() {

if [[ -z $OP_SESSION_marsdominion ]]; then
   eval $(op signin marsdominion)
fi
GIT_TOKEN=$(op get item "GitHub"|jq -r '.details.sections[] | select(.fields).fields[] | select(.t== "Personal Laptop").v')

unset OP_SESSION_marsdominion
}
