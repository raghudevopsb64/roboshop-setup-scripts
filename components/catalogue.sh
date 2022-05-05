#!/usr/bin/env bash

source components/common.sh
checkRootUser

## useradd roboshop
#
#$ curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
#$ cd /home/roboshop
#$ unzip /tmp/catalogue.zip
#$ mv catalogue-main catalogue
#$ cd /home/roboshop/catalogue
#$ npm install
#
#
#    Update `MONGO_DNSNAME` with MongoDB Server IP
#
## mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
## systemctl daemon-reload
## systemctl start catalogue
## systemctl enable catalogue
#

ECHO "Configure NodeJS YUM Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${LOG_FILE}
statusCheck $?

ECHO "Install NodeJS"
yum install nodejs  gcc-c++ -y &>>${LOG_FILE}
statusCheck $?

id roboshop &>>${LOG_FILE}
if [ $? -ne 0 ]; then
  ECHO "Add Application User"
  useradd roboshop &>>${LOG_FILE}
  statusCheck $?
fi

ECHO "Download Application Content"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>${LOG_FILE}
statusCheck $?

ECHO "Extract Application Archive"
cd /home/roboshop && rm -rf catalogue &>>${LOG_FILE} && unzip /tmp/catalogue.zip &>>${LOG_FILE}  && mv catalogue-main catalogue
statusCheck $?

ECHO "Install NodeJS Modules"
cd /home/roboshop/catalogue && npm install &>>${LOG_FILE}
statusCheck $?



