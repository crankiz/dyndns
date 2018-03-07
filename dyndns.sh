#!/bin/bash
AUTH=USER:PASS
HOSTNAME=domain.com
LOOPIA=https://dyndns.loopia.se
WANIP=$(curl -s curlmyip.net)
URL="$LOOPIA?hostname=$HOSTNAME&myip=$WANIP"
LOGPATH=/var/log/dyndns/dyndns.log
DATE=$(date "+%Y-%m-%d %H:%M:%S")
LASTIP=$(tail -1 $LOGPATH|awk '{print $3}')

loopia_dyndns () {
  curl -s --user "$AUTH" "$URL"
}

if [ $WANIP = $LASTIP ]
  then
    echo $DATE $WANIP nochange >> $LOGPATH
else
  loopia_dyndns
  echo $DATE $WANIP new >> $LOGPATH
fi
