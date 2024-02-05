script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print "Install Nginx"
dnf install nginx -y

func_print "Start the nginx service"
systemctl enable nginx
systemctl start nginx

func_print "Download the frontend code"
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

func_print "Unzip the frontend code"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

func_print "Copy the roboshop configuration file"
cp ${script_path}/roboshop.conf /etc/nginx/default.d/roboshop.conf

func_print "Restart Nginx Service"
systemctl restart nginx