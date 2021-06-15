#!/bin/bash
DISPLAY=:0 scrot -o -u /root/shot.png
smbclient //ISWEB05.intern.i-sone.no/status/ -U=USERSTRING:SMBSTRING -c 'put /root/shot.png shot.png'

