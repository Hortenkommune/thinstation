
host="$(grep "HDUPDATE_SERVER=" /etc/thinstation.defaults | sed 's/^HDUPDATE_SERVER=//')"
ip="$(ifconfig | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | head -1)"
now="$(date +%d/%m/%Y-%T)"

curl -X PUT -H "Content-Type: application/json" -d "{\"lastseen\": \"${now}\",\"lastknownip\":\"${ip}\"}" "http://${host}/thinclient/$(hostname)"