# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash
tf() {
  case $1 in
    acg-dev) 
        export PROJECT=acg-dev
        export AWS_REGION=us-east-1
        ;;
    acg-shared) 
        export PROJECT=acg-shared
        export AWS_REGION=us-east-1
        ;;
    acg-prod) 
        export PROJECT=acg-prod
        export AWS_REGION=us-east-1
        ;;
    acg-master) 
        export PROJECT=acg-master
        export AWS_REGION=us-east-1
        ;;
    cdp-du)
        export PROJECT=tools-dev-us
        export AWS_REGION=us-west-2
        ;;
    cdp-su)
        export PROJECT=tools-staging-us
        export AWS_REGION=us-east-2
        ;;
    cdp-se)
        export PROJECT=tools-staging-eu
        export AWS_REGION=eu-west-1
        ;;
    cdp-pu)
        export PROJECT=tools-production-us
        export AWS_REGION=us-east-2
        ;;
    cdp-pe)
        export PROJECT=tools-production-eu
        export AWS_REGION=eu-west-1
        ;;
    *)
        echo "usage: $0 {acg-dev | acg-shared | acg-pdod | acg-master | cdp-du | cdp-su | cdp-se | cdp-pu | cdp-pe} "
  esac
}
