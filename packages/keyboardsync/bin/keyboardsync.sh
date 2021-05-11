#!/bin/bash
processname="xfce4-session"
process="$(ps aux | grep -v "grep" | grep $processname)"
if [ -z "$process" ]
then
	while pgrep "$processname" > /dev/null ; do sleep 2 ; echo "$processname is not active." ; done
else
    /bin/setxkbmap -synch -display :0 -verbose
fi