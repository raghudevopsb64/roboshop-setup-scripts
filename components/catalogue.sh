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
yum install nodejs  gcc-c++ -y
statusCheck $?

ECHO "Add Application User"
useradd roboshop
statusCheck $?

