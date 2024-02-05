app_user=roboshop

func_node(){
  echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Install NodeJS<<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
  dnf module disable nodejs -y
  dnf module enable nodejs:18 -y
  dnf install nodejs -y

  echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Add the roboshop user <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
  useradd ${app_user}

  echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Download catalogue code <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
  mkdir /app
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

  echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Unzip the catalogue code <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
  cd /app
  unzip /tmp/${component}.zip

  echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Download Nodejs Dependencies <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
  cd /app
  npm install

  echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Copy the catalogue service file<<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service


  echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Start the catalogue service <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}
}