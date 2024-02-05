app_user=roboshop

func_node(){
  func_print "Install NodeJS"
  dnf module disable nodejs -y
  dnf module enable nodejs:18 -y
  dnf install nodejs -y

  func_print "Add the roboshop user"
  useradd ${app_user}

  func_print "Download catalogue code"
  mkdir /app
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

  func_print "Unzip the catalogue code"
  cd /app
  unzip /tmp/${component}.zip

  func_print "Download Nodejs Dependencies"
  cd /app
  npm install

  func_print "Copy the catalogue service file"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service


  func_print "Start the catalogue service"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}
}

func_print(){
  echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> $1 <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
}