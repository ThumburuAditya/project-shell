app_user=roboshop
logfile=/tmp/robo.log

func_node(){
  func_print "Install NodeJS"
  dnf module disable nodejs -y &>>${logfile}
  dnf module enable nodejs:18 -y &>>${logfile}
  dnf install nodejs -y &>>${logfile}

  func_print "Add the roboshop user"
  useradd ${app_user} &>>${logfile}

  func_print "Download catalogue code"
  mkdir /app &>>${logfile}
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${logfile}

  func_print "Unzip the catalogue code"
  cd /app &>>${logfile}
  unzip /tmp/${component}.zip &>>${logfile}

  func_print "Download Nodejs Dependencies"
  cd /app &>>${logfile}
  npm install &>>${logfile}
  if [ $? -eq 0 ]
  then
    echo "Success"
  else
    echo "failure"
  fi

  func_print "Copy the catalogue service file"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service &>>${logfile}


  func_print "Start the catalogue service"
  systemctl daemon-reload &>>${logfile}
  systemctl enable ${component} &>>${logfile}
  systemctl start ${component} &>>${logfile}
}

func_print(){
  echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> $1 <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
}