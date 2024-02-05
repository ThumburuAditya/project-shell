script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=catalogue

func_node

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Copy the mongodb repo <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Install mongo client <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
dnf install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>>>> Load the schema <<<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
mongo --host 172.31.44.217 </app/schema/catalogue.js