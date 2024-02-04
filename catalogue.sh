echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Install NodeJS<<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Add the roboshop user <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
useradd roboshop

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Download catalogue code <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Unzip the catalogue code <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
cd /app
unzip /tmp/catalogue.zip

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Download Nodejs Dependencies <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
cd /app
npm install

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Copy the catalogue service file<<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
cp /home/centos/project-shell/catalogue.service /etc/systemd/system/catalogue.service


echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Start the catalogue service <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Copy the mongodb repo <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
cp /home/centos/project-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Install mongo client <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
dnf install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Load the schema <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
mongo --host 172.31.44.217 </app/schema/catalogue.js