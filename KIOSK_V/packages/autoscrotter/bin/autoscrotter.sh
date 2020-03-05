#!/bin/bash
rm -f ~/shot.png
scrot -u ~/shot.png
curl --upload-file ~/shot.png -u USERSTRING SMBSTRING