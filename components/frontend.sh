#!/usr/bin/env bash

source components/common.sh
checkRootUser


echo "Installing Nginx"
yum install nginx -y >/tmp/roboshop.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo "Downloading Frontend Code"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >/tmp/roboshop.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

cd /usr/share/nginx/html

echo "Removing Old Files"
rm -rf * >/tmp/roboshop.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo "Extracting Zip Content"
unzip /tmp/frontend.zip >/tmp/roboshop.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo "Copying extracted Content"
mv frontend-main/* . >/tmp/roboshop.log
mv static/* . >/tmp/roboshop.log
rm -rf frontend-main README.md >/tmp/roboshop.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo "Copy RoboShop Nginx Config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf >/tmp/roboshop.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo "Start Nginx Service"
systemctl enable nginx >/tmp/roboshop.log
systemctl restart nginx >/tmp/roboshop.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi 

