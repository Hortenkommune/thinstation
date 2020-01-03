#!/bin/bash
filetocheck="/tmp/ica_receiver_clear_crentials_alive"
serverip=$(export | grep SERVER_IP | cut -d '"' -f2)
currentver="$(grep HDUPDATE_WS /etc/thinstation.defaults | sed 's/^HDUPDATE_WS_VERSION=//')"
requiredver="$(curl -s ${serverip}/thinstation.conf.network | grep HDUPDATE_SERVER | sed 's/^HDUPDATE_SERVER_VERSION=//')"
 if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then 
        echo "Current server version is $requiredver, installed version is $currentver"
        echo "No updated needed, continuing"
 else
        echo "Current server version is $requiredver, installed version is $currentver"
        echo "Update is needed, executing update crew"
        while [ -f $filetocheck ] ; do sleep 15; done
        /sbin/reboot
 fi
