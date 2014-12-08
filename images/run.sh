#!/bin/bash
service ssh start
exec supervisord -c supervisord-images.conf
