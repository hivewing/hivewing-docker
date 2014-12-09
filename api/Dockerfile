#
FROM dockerfile/java
RUN sudo apt-get update

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

EXPOSE 3000
CMD ["/srv/run.sh"]
