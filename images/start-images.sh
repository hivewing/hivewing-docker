#!/bin/bash
# Switch to the git user..
export HIVEWING_GITOLITE_ROOT=/home/git/.gitolite
export HIVEWING_GITOLITE_SHELL_COMMAND=/home/git/bin/gitolite
export HIVEWING_GITOLITE_REPOSITORIES_ROOT=/home/git/repositories
export HOME=/home/git/
export ROOT=/home/git

exec java -jar /home/git/hivewing-images.jar
