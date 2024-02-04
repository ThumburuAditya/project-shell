source common.sh

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Install MongoDB <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
cp /home/centos/project-shell/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Start MongoDB <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
systemctl enable mongod
systemctl start mongod

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Update the listen Address of MongoDB <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf


echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Restart the MongoDB Service <<<<<<<<<<<<<<<<<<<<<<<<<<\e[36m"
systemctl restart mongod