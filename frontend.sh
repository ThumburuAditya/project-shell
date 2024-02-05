script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Install Nginx <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
dnf install nginx -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Start the nginx service <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl start nginx

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Download the frontend code <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Unzip the frontend code <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Copy the roboshop configuration file <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
cp ${script_path}/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Restart Nginx Service <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl restart nginx