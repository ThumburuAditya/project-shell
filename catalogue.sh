script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=catalogue


func_node

func_print "Copy the mongodb repo"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

func_print "Install mongo client"
dnf install mongodb-org-shell -y

func_print "Load the schema"
mongo --host 172.31.44.217 </app/schema/catalogue.js