echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Install NodeJS<<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y

echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Add the roboshop user <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Download catalogue code <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Unzip the catalogue code <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip

echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Download Nodejs Dependencies <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
cd /app
npm install

echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Copy the catalogue service file<<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service


echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Start the catalogue service <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Copy the mongodb repo <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Install mongo client <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
dnf install mongodb-org-shell -y

echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Load the schema <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
mongo --host 172.31.44.217 </app/schema/catalogue.js