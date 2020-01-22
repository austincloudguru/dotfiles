# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash

# Get the Account Number
getaccount() {
  aws sts get-caller-identity \
    --query "Account" --output text
}

# Set the AWS Region
setregion() {
  export AWS_DEFAULT_REGION=$1
}

# List Available Volumes
aws-av() {
  if [ -z "$1" ]; then
   echo "Need to include the number of days to list"
  else
    for region in `aws ec2 describe-regions --output text | cut -f 2|cut -d . -f 2`;
    do 
      echo "-- $region"; 
        aws ec2 describe-volumes --region $region --filters "Name=status,Values=available" \
          --query "Volumes[?CreateTime<='$(date -v -${1}d +%Y-%m-%d)'].VolumeId" \
          --output text        
      echo ;
    done
  fi
}

# Cleanup Available Volumes
aws-avc() {
  if [ -z "$1" ]; then
   echo "Needs number of days old to clean up"
  else
    for region in `aws ec2 describe-regions --output text | cut -f 2|cut -d . -f 2`;
    do 
      echo "-- $region"; 
      for a in `aws ec2 describe-volumes \
        --region $region \
        --filters "Name=status,Values=available" \
        --query "Volumes[?CreateTime<='$(date -v -${1}d +%Y-%m-%d)'].VolumeId" \
        --output text`
      do
        echo "Deleting $a..."
        aws ec2 delete-volume --region $region --volume-id $a
      done        
      echo ;
    done
  fi
}
