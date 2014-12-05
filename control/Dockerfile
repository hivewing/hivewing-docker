#
FROM dockerfile/java
RUN sudo apt-get update

ADD hivewing-control.jar /srv/hivewing-control.jar

EXPOSE 80
CMD ["java", "-jar", "/srv/hivewing-control.jar"]
