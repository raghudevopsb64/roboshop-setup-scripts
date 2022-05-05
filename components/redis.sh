#!/usr/bin/env bash

source components/common.sh
checkRootUser

# curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
# yum install redis -y

#pdate the BindIP from 127.0.0.1 to 0.0.0.0 in config file /etc/redis.conf & /etc/redis/redis.conf
# systemctl enable redis
# systemctl start redis


ECHO "Configure YUM Repos"
curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>${LOG_FILE}
statusCheck $?

ECHO "Install Redis"
yum install redis -y &>>${LOG_FILE}
statusCheck $?

ECHO "Update Redis Configuration"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  &>>${LOG_FILE}
statusCheck $?

ECHO "Start Redis Service"
systemctl enable redis &>>${LOG_FILE} && systemctl restart redis &>>${LOG_FILE}
statusCheck $?
