#!/usr/bin/env bash

USER_ID=$(id -u)

if [ "$USER_ID" -ne "0" ]; then
  echo You are suppose to be running this script as sudo or root user
else

fi
