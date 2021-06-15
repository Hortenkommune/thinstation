#!/bin/bash
host="$(grep "HDUPDATE_SERVER=" /etc/thinstation.defaults | sed 's/^HDUPDATE_SERVER=//')"
ip="$(ifconfig | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | head -1)"
now="$(date +%d/%m/%Y-%T)"
wsver="$(grep "HDUPDATE_WS" /etc/thinstation.defaults | sed 's/^HDUPDATE_WS_VERSION=//')"

jsondata='{"lastseen": "%s","lastknownip":"%s","wsversion": "%s"}\n'
body="$(printf "$jsondata" "$now" "$ip" "$wsver")"

curl -X PUT -H "Content-Type: application/json" -d "${body}" "${host}/thinclient/$(hostname)"