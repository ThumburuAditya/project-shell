script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
logfile=/tmp/robo.log

func_print "Install Nginx"
dnf install nginx -y &>>${logfile}

func_print "Start the nginx service"
systemctl enable nginx &>>${logfile}
systemctl start nginx &>>${logfile}

func_print "Download the frontend code"
rm -rf /usr/share/nginx/html/* &>>${logfile}
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${logfile}

func_print "Unzip the frontend code"
cd /usr/share/nginx/html &>>${logfile}
unzip /tmp/frontend.zip &>>${logfile}

func_print "Copy the roboshop configuration file"
cp ${script_path}/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${logfile}

func_print "Restart Nginx Service"
systemctl restart nginx &>>${logfile}