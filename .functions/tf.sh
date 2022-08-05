# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash
tf() {
  case $1 in
    acg-master) 
        export PROJECT=acg-master
        export AWS_REGION=us-east-1
        ;;
    cdp-du)
        export PROJECT=tools-dev-us
        export AWS_REGION=us-west-2
        export AWS_ORG_ID="d-90676f2986"
        ;;
    cdp-su)
        export PROJECT=tools-staging-us
        export AWS_REGION=us-east-2
        export AWS_ORG_ID="d-90676f2986"
        ;;
    cdp-se)
        export PROJECT=tools-staging-eu
        export AWS_REGION=eu-west-1
        export AWS_ORG_ID="d-90676f2986"
        ;;
    cdp-pu)
        export PROJECT=tools-production-us
        export AWS_REGION=us-east-2
        export AWS_ORG_ID="d-90676f2986"
        ;;
    cdp-pe)
        export PROJECT=tools-production-eu
        export AWS_REGION=eu-west-1
        export AWS_ORG_ID="d-90676f2986"
        ;;
    cdp-gw)
        export PROJECT=tools-govcloud-west
        export AWS_REGION=us-gov-west-1
        ;;
    sec-du)
        export PROJECT=security-dev
        export AWS_REGION=us-east-1
        export AWS_ORG_ID="d-90676ccecb"
        ;;
    sec-pu)
        export PROJECT=security-prod
        export AWS_REGION=us-east-1
        export AWS_ORG_ID="d-90676f2986"
        ;;
    master-du)
        export PROJECT=dev-master
        export AWS_REGION=us-east-1
        export AWS_ORG_ID="d-90676ccecb"
        ;;
    master-pu)
        export PROJECT=prod-master
        export AWS_REGION=us-east-1
        export AWS_ORG_ID="d-90676f2986"
        ;;
    *)
        echo "usage: $0 {acg-master | cdp-du | cdp-su | cdp-se | cdp-pu | cdp-pe | master-du | master-pu} "
  esac
}
