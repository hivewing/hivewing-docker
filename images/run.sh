#!/bin/bash
service ssh start
exec supervisord -n -c supervisord.conf
