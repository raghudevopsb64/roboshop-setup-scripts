#!/usr/bin/env bash

source components/common.sh
checkRootUser

#
#curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
## yum install -y mongodb-org
## systemctl enable mongod
## systemctl start mongod
#
#Update /etc/mongod.conf
#systemctl restart mongod
#
## curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
#
## cd /tmp
## unzip mongodb.zip
## cd mongodb-main
## mongo < catalogue.js
## mongo < users.js


ECHO "Setup MongoDB Yum repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>${LOG_FILE}
statusCheck $?

ECHO "Installing MongoDB"
yum install -y mongodb-org  &>>${LOG_FILE}
statusCheck $?

