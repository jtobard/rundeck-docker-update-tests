# Dockerfile for rundeck

FROM debian:jessie



RUN ping -c2 ftp.debian.org
RUN apt-get update
RUN apt-get install -y bash ca-certificates openjdk-7-jre-headless
RUN apt-get install -y bash openssh-client pwgen curl git mysql-client

ADD http://dl.bintray.com/rundeck/rundeck-deb/rundeck-2.6.9-1-GA.deb /tmp/rundeck.deb
ADD http://dl.bintray.com/rundeck/rundeck-deb/rundeck-2.7.1-1-GA.deb /tmp/rundeck-upd.deb
COPY . /app
WORKDIR /app
RUN useradd -d /var/lib/rundeck -s /bin/false rundeck
RUN chmod u+x ./install.sh


EXPOSE 4440

CMD ./install.sh
