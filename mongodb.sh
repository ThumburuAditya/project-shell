script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
logfile=/tmp/robo.log

func_print "Install MongoDB"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo &>>${logfile}
dnf install mongodb-org -y &>>${logfile}

func_print "Start MongoDB"
systemctl enable mongod &>>${logfile}
systemctl start mongod &>>${logfile}

func_print "Update the listen Address of MongoDB"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf &>>${logfile}


func_print "Restart the MongoDB Service"
systemctl restart mongod &>>${logfile}