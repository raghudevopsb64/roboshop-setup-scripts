#!/usr/bin/env bash

source components/common.sh
checkRootUser


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

ECHO "Configure Listen Address in MonogBD Configuration"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
statusCheck $?

ECHO "Start MongoDB Service"
systemctl restart mongod &>>${LOG_FILE} && systemctl enable mongod >>${LOG_FILE}
statusCheck $?

ECHO "Download Schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"  >>${LOG_FILE}
statusCheck $?

ECHO "Extract Schema Zip"
cd /tmp && unzip -o mongodb.zip >>${LOG_FILE}
statusCheck $?

cd mongodb-main
ECHO "Load Schema"
mongo < catalogue.js >>${LOG_FILE} && mongo < users.js >>${LOG_FILE}
statusCheck $?
