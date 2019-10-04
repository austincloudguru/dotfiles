# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then

    # Runs Ansible
    updatemac() {
      unset PIP_REQUIRE_VIRTUALENV
      cd ~/mac-ansible/macos-config
      ansible-playbook playbook.yml -i inventory -K
      export PIP_REQUIRE_VIRTUALENV=true
    }

    alias abs='ssh abs.austincloud.guru -t tmuxinator bastion'


fi
