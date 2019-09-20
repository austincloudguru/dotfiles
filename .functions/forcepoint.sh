# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash

# AWS CDP-DEV account
cdp-dev() {
  aws-okta exec cdp-dev -- /bin/bash
}

# AWS CDP-DEV account
cdp-dev() {
  aws-okta exec cdp-cicd -- /bin/bash
}

# AWS fp-cloudsec-main account
cdp-dev() {
  aws-okta exec cdp-main -- /bin/bash
}
