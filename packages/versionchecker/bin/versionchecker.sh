#!/bin/bash
set -e 
set -o pipefail
service="wfica"
servicename="Citrix Workspace"
serverip=$(grep "param bootserver" /etc/thinstation.defaults | sed 's/^param bootserver//') || /bin/true
currentver="$(grep HDUPDATE_WS /etc/thinstation.defaults | sed 's/^HDUPDATE_WS_VERSION=//')"
requiredver="$(curl -s ${serverip}/thinstation.conf.network | grep HDUPDATE_SERVER | sed 's/^HDUPDATE_SERVER_VERSION=//')" || /bin/true

if [ -z "$requiredver" ]
then
      echo "Required version variable is empty, stopping..."
      exit
else
      echo "Required version variable is NOT empty, continuing..."
fi

if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then 
        echo "Current server version is $requiredver, installed version is $currentver"
        echo "No updated needed, continuing..."
else
        echo "Current server version is $requiredver, installed version is $currentver"
        echo "Update is needed, executing update crew..."
        echo "Checking if $servicename is still running"
        while pgrep "$service" > /dev/null ; do sleep 10 ; echo "$servicename is still active." ; done
        echo "This system needs to reboot to update."
        /sbin/reboot
fi
