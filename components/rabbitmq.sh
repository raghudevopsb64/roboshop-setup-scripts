#!/usr/bin/env bash

source components/common.sh
checkRootUser


#1. Start RabbitMQ
#
#```sql
## systemctl enable rabbitmq-server
## systemctl start rabbitmq-server
#```
#
#RabbitMQ comes with a default username / password as `guest`/`guest`. But this user cannot be used to connect. Hence we need to create one user for the application.
#
#1. Create application user
#
#```sql
## rabbitmqctl add_user roboshop roboshop123
## rabbitmqctl set_user_tags roboshop administrator
## rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
#```
#
#Ref link : [https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management](https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management)

ECHO "Setup YUM Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${LOG_FILE}
statusCheck $?

ECHO "Install RabbitMQ & Erlang"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm rabbitmq-server -y &>>${LOG_FILE}
statusCheck $?

ECHO "Start RabbitMQ Service"
systemctl enable rabbitmq-server &>>${LOG_FILE}  && systemctl start rabbitmq-server &>>${LOG_FILE}
statusCheck $?

rabbitmqctl list_users | grep roboshop &>>${LOG_FILE}
if [ $? -ne 0 ]; then
  ECHO "Create an Application User"
  rabbitmqctl add_user roboshop roboshop123 &>>${LOG_FILE}
  statusCheck $?
fi

ECHO "Setup Application User Persmissions"
rabbitmqctl set_user_tags roboshop administrator  &>>${LOG_FILE} && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>>${LOG_FILE}
statusCheck $?

