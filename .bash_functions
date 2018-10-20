# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#

# Run mac-playbook
f_arr[0]="updatemac:Runs Ansible to update MacOS"
updatemac() {
  unset PIP_REQUIRE_VIRTUALENV
  cd ~/mac-ansible/macos-config
  ansible-playbook playbook.yml -i inventory -K
  export PIP_REQUIRE_VIRTUALENV=true
}

f_arr[1]="git_prompt:Outputs the branch and status for my prompt"
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