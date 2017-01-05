# Dockerfile for rundeck

FROM centos:7



RUN yum install -y java-1.7.0-openjdk


ADD http://dl.bintray.com/rundeck/rundeck-rpm/rundeck-2.6.9-1.21.GA.noarch.rpm /tmp/rundeck.rpm
ADD http://dl.bintray.com/rundeck/rundeck-rpm/rundeck-config-2.6.9-1.21.GA.noarch.rpm /tmp/rundeck-config.rpm

ADD http://dl.bintray.com/rundeck/rundeck-rpm/rundeck-2.7.0-1.24.GA.noarch.rpm /tmp/rundeck-upd.rpm
ADD http://dl.bintray.com/rundeck/rundeck-rpm/rundeck-config-2.7.0-1.24.GA.noarch.rpm /tmp/rundeck-config-upd.rpm
COPY . /app
WORKDIR /app

RUN chmod u+x ./install.sh


EXPOSE 4440

CMD ./install.sh
