#!/bin/bash
/opt/Citrix/ICAClient/selfservice2
ps -ef | grep selfservice2 | grep -v grep | awk '{print $2}' | xargs kill
/opt/Citrix/ICAClient/selfservice2
