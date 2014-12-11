#! /bin/bash
# $1 = private-key-path
# $2 = repo-dir
# $3 = remote-url
export GIT_SSH=$(pwd)/local-ssh.sh
echo $GIT_SSH

pushd .
cd test-repo
  git remote rm -f testing
  git remote add testing $2
  git push testing master
popd
