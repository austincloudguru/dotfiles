# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env zsh

# AWS CDP-DEV account
cdp-dev() {
  aws-okta exec cdp-dev -- /bin/zsh
}

# AWS CDP-DEV account
cdp-cicd() {
  aws-okta exec cdp-cicd -- /bin/zsh
}

# AWS fp-cloudsec-main account
cdp-main() {
  aws-okta exec fp-cloudsec-main -- /bin/zsh
}
