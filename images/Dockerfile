FROM ubuntu:14.04

RUN apt-get update -q
RUN apt-get install -qy supervisor sudo openssh-server build-essential git openjdk-7-jre wget

# Generate the system keys
RUN /usr/bin/ssh-keygen -A

RUN adduser --system --group --shell /bin/sh git
RUN echo "user    ALL=(ALL:ALL) ALL" > /etc/sudoers
RUN echo git:git | chpasswd

# This is now a git user with leiningen installed
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

RUN mkdir -p /var/run/sshd
RUN mkdir -p /home/git/bin

RUN wget -O /home/git/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN chmod 0755 /home/git/bin/lein

RUN cd /home/git; git clone git://github.com/sitaramc/gitolite
RUN cd /home/git; gitolite/install -ln /home/git/bin

#Following this:  http://gitolite.com/gitolite/odds-and-ends.html#server-side-admin
RUN cd /home/git; /home/git/bin/gitolite setup -a dummy

# Copy over our gitolite.conf
ADD gitolite.conf /home/git/.gitolite/conf/gitolite.conf

# Add the post-receive hook we need for the SQS push
ADD gitolite.post-receive.hook /home/git/.gitolite/hooks/common/post-receive
RUN chmod 755 /home/git/.gitolite/hooks/common/post-receive

# Run the setup again?.
RUN cd /home/git; /home/git/bin/gitolite setup

# Add the config file and hives dir.
RUN mkdir -p /home/git/.gitolite/conf/hives
RUN /home/git/bin/gitolite compile
RUN /home/git/bin/gitolite trigger POST_COMPILE

# Create the supervisor
ADD /start-images.sh /home/git/start-images.sh
ADD /run.sh /home/git/run.sh
ADD /supervisord.conf /home/git/supervisord.conf

# Add the uberjar
ADD hivewing-images.jar /home/git/hivewing-images.jar

RUN chmod 755 /home/git/*.sh
RUN chown -R git /home/git

ENV     HOME /home/git
WORKDIR /home/git
#USER    git

EXPOSE 22
CMD ["/home/git/run.sh"]
