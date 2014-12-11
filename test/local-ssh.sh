#!/bin/sh
/usr/bin/ssh -p 2222 -i /home/cfitzhugh/working/hivewing-docker/test/testuser.private "$@"
#-i /home/cfitzhugh/working/hivewing-docker/test/testuser.private "$@"
#-o StrictHostKeyChecking=no -o BatchMode=yes "$@"
