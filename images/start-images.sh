#!/bin/bash
# Switch to the git user..
export HIVEWING_GITOLITE_ROOT=/home/git/.gitolite
export HIVEWING_GITOLITE_SHELL_COMMAND=/home/gitolite/bin/gitolite
export HIVEWING_GITOLITE_REPOSITORIES_ROOT=/home/gitolite/repositories

exec java -jar /home/git/hivewing-images.jar
