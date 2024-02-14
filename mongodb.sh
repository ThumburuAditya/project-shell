script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print "Install MongoDB"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y

func_print "Start MongoDB"
systemctl enable mongod
systemctl start mongod

func_print "Update the listen Address of MongoDB"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

func_print "Restart the MongoDB Service"
systemctl restart mongod