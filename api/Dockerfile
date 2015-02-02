#
FROM ubuntu:14.04
RUN sudo apt-get update -q
RUN apt-get install -qy supervisor sudo build-essential openjdk-7-jre

RUN adduser --system --group --shell /bin/sh hivewing
RUN echo "hivewing    ALL=(ALL:ALL) ALL" > /etc/sudoers
RUN echo hivewing:hivewing | chpasswd

ADD /hivewing-api.uber.jar  /home/hivewing/hivewing-api.jar

ADD /run.sh /home/hivewing/run.sh
ADD /supervisord.conf /home/hivewing/supervisord.conf
ADD /start-api.sh /home/hivewing/start-api.sh

RUN chmod 755 /home/hivewing/*.sh
RUN chown -R hivewing /home/hivewing

ENV     HOME /home/hivewing
WORKDIR /home/hivewing
USER    hivewing

EXPOSE 5000
CMD ["/home/hivewing/run.sh"]
