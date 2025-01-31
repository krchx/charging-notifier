#!/bin/bash

# Check if charging-notifier is installed
if command -v /usr/libexec/charging-notifier/notifier.py &> /dev/null;
then
    echo "charging-notifier is installed."
    read -p "Do you want to change the threshold? (y/N): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        read -p "Enter charging threshold percentage: " charging_threshold
        read -p "Enter discharging threshold percentage: " discharging_threshold

        # Update config.ini with user-provided values
        sed -i "s/charging_threshold = .*/charging_threshold = $charging_threshold/" ../src/config.ini
        sed -i "s/discharging_threshold = .*/discharging_threshold = $discharging_threshold/" ../src/config.ini

        # Stop the charging-notifier service
        systemctl --user stop charging-notifier.timer

        # Overwrite existing congig.ini file in /usr/libexec/charging-notifier
        cp ../src/config.ini /usr/libexec/charging-notifier/config.ini

        # Restart the charging-notifier service
        systemctl --user start charging-notifier.timer

        echo "Threshold change completed."
    else
        echo "Threshold change aborted."
        exit 0
    fi
else
    echo "charging-notifier is not installed. Please install it first."
    exit 1
fi