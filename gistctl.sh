#!/bin/bash

token=${GITHUB_TOKEN}
URL=https://api.github.com/gists/public
since=""
user=""
SINCE=""
output=""
OUTPUT=""

usage()
{
  echo "Usage: $0 -c [API Command] -u [User name] -S [since yyyy-mm-dd:hh:mm:ssZ]"
  echo "-c: show (REQUIRED, currently only show is available, fetch and list coming soon)"
  echo "-u: gist userid (optional, default is all public)"
  echo "-S: Since format yyyy-mm-dd:hh:mm:ssZ (optioanl)"
  echo "NOTE: Your github token can be set in your ENV as GITHUB_TOKEN, or can be supplied on the command line with the '-t' option"
  echo
  exit
}

chk_timestamp()
{
# If this script has previously been run on this host,the since value will automatically be set to the timestamp of that initial execution.
# If not the value will be set to the current date and time
# If a specific 'since" value has been specified that will take precedence else use the date from the file for the 'since' value.

  if [[ -e /tmp/.gist-info ]]; then
    MYDATE=`cat /tmp/.gist-info`
    echo MYDATE=$MYDATE from file
  else
    MYDATE=`date +%Y-%m-%d:%H:%M:%SZ`
    echo $MYDATE > /tmp/.gist-info
    SINCE=""
    since="FirstTimeForce"
  fi

# After the initial execution the 'since' value can be overridden by using the '-S' option
  if [[ -z $since ]]; then
    SINCE="?'Since=$MYDATE'"
  fi

}
 
api_command()
{
  curl $OUTPUT -k -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${token}" -H "X-GitHub-Api-Version: 2022-11-28" ${URL}${SINCE}
  exit
}

while getopts "c:u:t:o:S:h" opt; do
  case "$opt" in
    c) 
      cmd=${OPTARG}
      ;;
    h)
      usage
      ;;
    u)
      user="$OPTARG"
      echo user set to $user
      URL=https://api.github.com/users/${user}/gists
      ;;
    t)
      token="$OPTARG"
      ;;
    o)
      output="$OPTARG"
      OUTPUT="-o $output"
      ;;
    S)
      since="$OPTARG"
      echo since set to $since
      SINCE="?'Since=$since'"
      ;;
    *)
      echo "Invalid Option"
      usage
      ;;
  esac
done

case ${cmd} in
  "show")
	chk_timestamp
	api_command
	;;
  *)
        usage
	;;
esac
