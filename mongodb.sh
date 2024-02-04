echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Install MongoDB <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
cp /home/centos/project-shell/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y

echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Start MongoDB <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl enable mongod
systemctl start mongod

echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Update the listen Address of MongoDB <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf


echo -e "\e[0m>>>>>>>>>>>>>>>>>>>>>>>> Restart the MongoDB Service <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl restart mongod