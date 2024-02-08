#!/bin/bash

# Function to check if script is run as root
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "This script must be run as root" >&2
        exit 1
    fi
}

# Function to append HandleLidSwitch=ignore to /etc/logind.conf
add_handle_lid_switch() {
    if grep -q "^HandleLidSwitch=" /etc/systemd/logind.conf; then
        echo "HandleLidSwitch is already defined in /etc/logind.conf"
    else
        echo "HandleLidSwitch=ignore" >> /etc/systemd/logind.conf
        echo "HandleLidSwitch=ignore added to /etc/systemd/logind.conf"
    fi
}

# Main function
main() {
    if ! check_root; then
        # If not root, ask for sudo authentication
        if sudo -v; then
            # If sudo authentication successful, call function to append HandleLidSwitch=ignore
            add_handle_lid_switch
        else
            echo "Authentication failed, aborting script" >&2
            exit 1
        fi
    else
        # If root, directly call function to append HandleLidSwitch=ignore
        add_handle_lid_switch
    fi
}

# Call main function
main

