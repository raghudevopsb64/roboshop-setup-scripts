#!/usr/bin/env bash

source components/common.sh
checkRootUser


echo "Installing Nginx"
yum install nginx -y >/tmp/roboshop.log
statusCheck $?

echo "Downloading Frontend Code"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >/tmp/roboshop.log
statusCheck $?

cd /usr/share/nginx/html

echo "Removing Old Files"
rm -rf * >/tmp/roboshop.log
statusCheck $?

echo "Extracting Zip Content"
unzip /tmp/frontend.zip >/tmp/roboshop.log
statusCheck $?

echo "Copying extracted Content"
mv frontend-main/* . >/tmp/roboshop.log
mv static/* . >/tmp/roboshop.log
rm -rf frontend-main README.md >/tmp/roboshop.log
statusCheck $?

echo "Copy RoboShop Nginx Config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf >/tmp/roboshop.log
statusCheck $?

echo "Start Nginx Service"
systemctl enable nginx >/tmp/roboshop.log
systemctl restart nginx >/tmp/roboshop.log
statusCheck $?

