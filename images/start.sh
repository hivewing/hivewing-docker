#! /bin/sh -

# handle the ssh key
if [ -n "$SSH_KEY" ]; then
  echo "Replace the admin ssh  key.\n"
  echo $SSH_KEY > /home/git/admin.pub
  su git -c "/home/git/bin/gitolite setup -pk=/home/git/admin.pub"
else
  su git -c "/home/git/bin/gitolite setup"
  echo "The built-in private key for admin:\n"
  cat /admin
fi

# Dump env into a file
env | grep "HIVEWING_" > /tmp/hivewing-env
sed -i -e 's/^/export /' /tmp/hivewing-env

# Start hivewing-images
supervisord -c /home/git/supervisord.conf
echo "Started supervisord.conf"

# Start up SSH and users..
/usr/sbin/sshd -D
