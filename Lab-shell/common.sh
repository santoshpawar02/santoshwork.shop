systemd_setup() {
    print_head "Setting up systemd service for $component"
    cp -r $component.service /etc/systemd/system/$component.service &>>$log_file
    print_head "Reloading systemd daemon..."
    systemctl daemon-reload &>>$log_file
    print_head "Enabling $component service..."
    systemctl enable $component &>>$log_file
    print_head "Restarting $component service..."
    systemctl restart $component &>>$log_file
}

artifact_download() {
    print_head "Adding roboshop user..."
    useradd roboshop &>>$log_file 
    print_head "Downloading $component artifact..."
    rm -rf /app &>>$log_file
    mkdir /app &>>$log_file
    curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
    cd /app 
    unzip /tmp/$component.zip &>>$log_file
}



nodejs_app_setup() {
    print_head "Setting up $component NodeJS service..."
    dnf module disable nodejs -y &>>$log_file
    dnf module enable nodejs:20 -y &>>$log_file
    print_head "Installing NodeJS"
    dnf install nodejs -y &>>$log_file
    print_head "Setting up $component prerequisites..."
    
    artifact_download
    cd /app 
    print_head "Installing NodeJS Dependencies"
    npm install &>>$log_file
    systemd_setup
}


maven_app_setup() {
    print_head "Setting up $component Maven service..."
    dnf install maven -y &>>$log_file
    print_head "Setting up $component prerequisites..."
    
    artifact_download
    cd /app 
    print_head "Building $component Maven service..."
    mvn clean package &>>$log_file
    print_head "Copying $component Maven service artifact..."
    mv target/$component-1.0.jar $component.jar  &>>$log_file
}


python_app_setup() {
    print_head "Setting up $component Python service..."
    dnf install python36 gcc python3-devel -y &>>$log_file
    print_head "Setting up $component prerequisites"
    
    artifact_download
    cd /app 
    print_head "Installing Python Dependencies"
    pip3.6 install -r requirements.txt &>>$log_file
    systemd_setup
}


print_head (){
  echo -e "\e[32m$*\e[0m"
  echo -e "\e[32m############################\e[0m" &>>$log_file
  echo -e "\e[32m$*\e[0m" &>>$log_file
  echo -e "\e[32m############################\e[0m" &>>$log_file
}

log_file="/tmp/roboshop.log"
rm -f $log_file