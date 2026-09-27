source common.sh
component=shipping
maven_app_setup
print_head "Installing MySQL Client"
dnf install mysql -y &>>$log_file
print_head "Loading Shipping Schema"
mysql -h mysql-dev.santoshwork.shop -uroot -pRoboShop@1 < /app/db/schema.sql &>>$log_file
print_head "Loading Shipping Data"
mysql -h mysql-dev.santoshwork.shop -uroot -pRoboShop@1 < /app/db/app-user.sql &>>$log_file
print_head "Loading Shipping Master Data"
mysql -h mysql-dev.santoshwork.shop -uroot -pRoboShop@1 < /app/db/master-data.sql &>>$log_file