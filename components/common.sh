checkRootUser() {
  USER_ID=$(id -u)

  if [ "$USER_ID" -ne "0" ]; then
    echo -e "\e[31mYou are suppose to be running this script as sudo or root user\e[0m"
    exit 1
  fi
}


statusCheck() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 1
  fi
}

LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

ECHO() {
  echo "=========================== $1 ===========================" >>${LOG_FILE}
  echo "$1"
}