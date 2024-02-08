#!/bin/bash

# Determine the home directory of the user who invoked sudo
user_home=$(eval echo ~$SUDO_USER)

# Function to set up brightness script
setup_brightness_script() {
    if [ ! -f "$user_home/.mbp-scripts/turnscreen.sh" ] || [ ! -x "$user_home/.mbp-scripts/turnscreen.sh" ]; then
        sudo -u "$SUDO_USER" $PWD/setup_brightness.sh
    fi

    # Set permissions for turnscreen.sh
    sudo chown "$SUDO_USER":"$SUDO_USER" "$user_home/.mbp-scripts/turnscreen.sh"
    sudo chmod 666 "$user_home/.mbp-scripts/turnscreen.sh"
    sudo chmod +x "$user_home/.mbp-scripts/turnscreen.sh"
}

# Function to check and set up the turnscreen alias
setup_turnscreen_alias() {
    if ! grep -q "alias turnscreen='$user_home/.mbp-scripts/turnscreen.sh'" "$user_home/.bashrc"; then
        echo "alias turnscreen='$user_home/.mbp-scripts/turnscreen.sh'" >> "$user_home/.bashrc"
    fi
}

# Function to create and set up lid monitor service
setup_lid_monitor_service() {
    # Create lid_monitor.sh script
    cat > "$user_home/.mbp-scripts/lid_monitor.sh" << EOF
#!/bin/bash

# Function to turn the screen on
turn_screen_on() {
    $user_home/.mbp-scripts/turnscreen.sh on
}

# Function to turn the screen off
turn_screen_off() {
    $user_home/.mbp-scripts/turnscreen.sh off
}

# Continuously monitor changes in the lid state
while true; do
    lid_state=\$(cat /proc/acpi/button/lid/LID0/state | awk '{print \$2}')
    if [ "\$lid_state" = "open" ]; then
        turn_screen_on
    else
        turn_screen_off
    fi
    sleep 1
done
EOF

    # Make lid_monitor.sh executable
    chmod +x "$user_home/.mbp-scripts/lid_monitor.sh"

    # Change SELinux context of lid_monitor.sh script
    sudo chcon -t bin_t "$user_home/.mbp-scripts/lid_monitor.sh"

    # Create lid_monitor.service file
    cat > /etc/systemd/system/lid_monitor.service << EOF
[Unit]
Description=Lid Monitor Service
After=network.target

[Service]
Type=simple
ExecStart=$user_home/.mbp-scripts/lid_monitor.sh

[Install]
WantedBy=multi-user.target
EOF

    # Reload systemd daemon
    systemctl daemon-reload

    # Enable and start the lid_monitor.service
    systemctl enable lid_monitor.service
    systemctl start lid_monitor.service

    echo "Lid monitor service set up successfully."
}

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Check and set up brightness script
setup_brightness_script

# Check and set up turnscreen alias
setup_turnscreen_alias

# Set up lid monitor service
setup_lid_monitor_service

