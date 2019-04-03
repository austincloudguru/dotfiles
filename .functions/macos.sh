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

    # odrive sync tool
    if [ -d ~/.odrive/bin ]; then
      OD_VERSION=$(ls ~/.odrive/bin)
      alias od='~/.odrive/bin/${OD_VERSION}/odrive.py'
    fi

    alias abs='ssh abs.austincloud.guru -t tmuxinator bastion'

fi
