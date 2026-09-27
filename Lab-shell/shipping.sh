source common.sh
component=shipping
maven_app_setup
dnf install mysql -y 
mysql -h mysql-dev.santoshwork.shop -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h mysql-dev.santoshwork.shop -uroot -pRoboShop@1 < /app/db/app-user.sql 
mysql -h mysql-dev.santoshwork.shop -uroot -pRoboShop@1 < /app/db/master-data.sql
