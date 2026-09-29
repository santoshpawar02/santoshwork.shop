source common.sh
component=shipping
maven_app_setup
print_head "Installing MySQL Client"
dnf install mysql -y &>>$log_file
exit_status_print $?


for file in schema app-user master-data; do
  print_head "Loading $file"
  mysql -h mysql-dev.santoshwork.shop -uroot -pRoboShop@1 < /app/db/$file.sql &>>$log_file
  exit_status_print $?
done    
