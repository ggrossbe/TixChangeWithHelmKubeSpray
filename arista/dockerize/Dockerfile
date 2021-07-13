FROM node:latest

MAINTAINER Srikant Noorani

RUN apt-get update -q && \
    apt-get dist-upgrade -y && \
    apt-get install -y net-tools && \
    apt-get install -y  traceroute && \
    apt-get clean -y && \
    apt-get autoclean

RUN apt-get install vim -y &&\
    mkdir /opt/ca/

COPY nodeApp.tar /opt/ca/

RUN cd /opt/ca && tar xvf nodeApp.tar

WORKDIR /opt/ca/nodeApp

#RUN npm install && npm audit fix && npm install sleep

CMD node /opt/ca/nodeApp/nodeMySQL.js
