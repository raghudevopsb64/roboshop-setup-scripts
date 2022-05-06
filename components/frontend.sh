#!/usr/bin/env bash

source components/common.sh
checkRootUser


ECHO "Installing Nginx"
yum install nginx -y &>>${LOG_FILE}
statusCheck $?

ECHO "Downloading Frontend Code"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>${LOG_FILE}
statusCheck $?

cd /usr/share/nginx/html

ECHO "Removing Old Files"
rm -rf * &>>${LOG_FILE}
statusCheck $?

ECHO "Extracting Zip Content"
unzip /tmp/frontend.zip &>>${LOG_FILE}
statusCheck $?

ECHO "Copying extracted Content"
mv frontend-main/* . &>>${LOG_FILE} && mv static/* . &>>${LOG_FILE} && rm -rf frontend-main README.md &>>${LOG_FILE}
statusCheck $?

ECHO "Copy RoboShop Nginx Config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>${LOG_FILE}
statusCheck $?

ECHO "Update Nginx Configuration"
sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/' -e '/user/ s/localhost/user.roboshop.internal/' -e '/cart/ s/localhost/cart.roboshop.internal/' -e '/shipping/ s/localhost/shipping.roboshop.internal/' -e '/payment/ s/localhost/payment.roboshop.internal/'  /etc/nginx/default.d/roboshop.conf
statusCheck $?

ECHO "Start Nginx Service"
systemctl enable nginx &>>${LOG_FILE} && systemctl restart nginx &>>${LOG_FILE}
statusCheck $?

