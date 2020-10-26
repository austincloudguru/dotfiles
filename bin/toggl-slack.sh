#!/bin/bash
#*******************************************************************************
# Name: toggl-slack
# Description: Start a Toggl action and set slack into DnD mode
# Author: Mark Honomichl (mark at austincloud dot guru)
#*******************************************************************************

#****************
# Variables
#****************
RUN_MODE="start"
SLACK_API="https://slack.com/api"
TOGGL_API="https://api.track.toggl.com/api/v8"
TOGGL_TOKEN=''
SLACK_TOKEN=''
FOCUS_TIME=`date -v+25M +'%s'`
STATUS_OUTPUT=false
DND_OUTPUT=false

#****************
# usage
#****************
usage()
{
echo -n "usage: $0  [OPTION]...

Script that Starts a Toggl Timer and Puts Slack in DnD

 Options:
  -d                Toggl Descriptsion
  -p                Toggl Project
  -t                Toggl Tags
"
}

#****************
# getopts
#****************
while getopts ":d:p:t:s" opt; do
  case $opt in
    d)
      description=$OPTARG
      ;;
    p)
      project=$OPTARG
      ;;
    s)
      RUN_MODE="stop"
      ;;
    t)
      tags=$OPTARG
      ;;
  \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

## Check the Variables
if [ $RUN_MODE == "start" ]
then
  # Make sure description is set
  if [ -z "$description" ]
  then
    usage
    exit
  fi
  
  # Make sure project is set
  if [ -z "$project" ]
  then
    usage
    exit
  fi
  
  # Make sure tags are set
  if [ -z "$tags" ]
  then
    usage
    exit
  fi

  if [ $project == "personal" ]
  then
    PID="151466119"
  else
    PID="151466122"
  fi
fi


start() 
{
  timery_object='{"time_entry": {"description": "'"$description"'", "pid": "'"$PID"'", "tags": ["'"$tags"'"], "created_with": "curl" }}'

  # Start the Toggl Timer
  toggl_curl=$(curl -s -u $TOGGL_TOKEN:api_token \
  -H "Content-Type: application/json" \
	-d "$timery_object" \
	-X POST https://api.track.toggl.com/api/v8/time_entries/start \
	| /usr/local/bin/jq -r .data.id \
  )

  if [ -z $toggl_curl ]
  then
    echo "Timer did not start"
  else  
    STATUS_OUTPUT=$(curl -s -X POST -H "Authorization: Bearer $SLACK_TOKEN" \
      -H 'Content-type: application/json' \
      --data '{ "profile": { "status_text": "Focused Work", "status_emoji": ":alarm_clock:", "status_expiration": '$FOCUS_TIME' } }' \
      $SLACK_API/users.profile.set|/usr/local/bin/jq -r .ok)
   
    if [ $STATUS_OUTPUT == "true" ]
    then
      DND_OUTPUT=$(curl -s -X POST "$SLACK_API/dnd.setSnooze?token=$SLACK_TOKEN&num_minutes=25&pretty=1"|/usr/local/bin/jq -r .ok)
      if [ $DND_OUTPUT != "true" ]
      then
        echo "DND was not set"
      fi
      echo "Time to Focus"
    else
      echo "Status not set"
    fi
  fi 
}

stop() {
  # Get the Current Running Entry
  toggl_current=$(curl -s -u $TOGGL_TOKEN:api_token \
                      -X GET $TOGGL_API/time_entries/current|/usr/local/bin/jq -r .data.id)

  if [ $toggl_current == "null" ]
  then
    echo "No Timer Running"
  else
    # Stop the Toggl timer
    toggl_stop=$(curl -s -u "$TOGGL_TOKEN:api_token" \
                         -H "Content-Type: application/json" \
                         -X PUT $TOGGL_API/time_entries/$toggl_current/stop|/usr/local/bin/jq -r .data.id)

  if [ -z $toggl_stop ]
  then
    echo "Timer did not stop"
  else  
    DND_OUTPUT=$(curl -s -X POST "$SLACK_API/dnd.endDnd?token=$SLACK_TOKEN"|/usr/local/bin/jq -r .ok)
    if [ $DND_OUTPUT != "true" ]
    then
      echo "DND was not turned off"
    else 
      STATUS_OUTPUT=$(curl -s -X POST -H "Authorization: Bearer $SLACK_TOKEN" \
                              -H 'Content-type: application/json' \
                              -d '{ "profile": { "status_text": "", "status_emoji": ""}}' \
                              $SLACK_API/users.profile.set|/usr/local/bin/jq -r .ok)
      if [ $STATUS_OUTPUT != "true" ]
      then
        echo "Status not Unset"
      fi
    fi
  fi
fi  
}

if [ $RUN_MODE == "start" ]
then
  start
else
  stop
fi
