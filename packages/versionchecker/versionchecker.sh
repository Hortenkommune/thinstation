#!/bin/bash
serverip=$(export | grep SERVER_IP | cut -d '"' -f2)
currentver="$(grep HDUPDATE_WS /etc/thinstation.defaults | sed 's/^HDUPDATE_WS_VERSION=//')"
requiredver="$(curl ${serverip}/thinstation.conf.network | grep HDUPDATE_SERVER | sed 's/^HDUPDATE_SERVER_VERSION=//')"
 if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then 
        echo "Greater than or equal to Server"
 else
        echo "Less than Server"
 fi
