systemd_setup() {
    echo "Setting up systemd service..."
    systemctl daemon-reload
    systemctl enable $component 
    systemctl restart $component
}