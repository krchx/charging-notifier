#!/bin/bash

# Prompt user for threshold values
read -p "Enter charging threshold percentage: " charging_threshold
read -p "Enter discharging threshold percentage: " discharging_threshold

# Update config.ini with user-provided values
sed -i "s/charging_threshold = .*/charging_threshold = $charging_threshold/" src/config.ini
sed -i "s/discharging_threshold = .*/discharging_threshold = $discharging_threshold/" src/config.ini

# Create a python virtual environment
pip3 install -r requirements.txt

# Copy the notifier script to /usr/libexec/charging-notifier
sudo mkdir -p /usr/libexec/charging-notifier
sudo cp src/* /usr/libexec/charging-notifier/

# Create a user systemd directory and copy the service and timer files
mkdir -p ~/.config/systemd/user
cp systemd/charging-notifier.service ~/.config/systemd/user/
cp systemd/charging-notifier.timer ~/.config/systemd/user/

# Copy systemd service and timer files to the appropriate directory
sudo cp systemd/charging-notifier.service ~/.config/systemd/user/
sudo cp systemd/charging-notifier.timer ~/.config/systemd/user/

# Copy the sound file to /usr/share/sounds/charging-notifier/
sudo mkdir -p /usr/share/sounds/charging-notifier
sudo cp sounds/* /usr/share/sounds/charging-notifier/

# Enable and start the systemd service and timer
systemctl --user daemon-reload
systemctl --user enable charging-notifier.timer
systemctl --user start charging-notifier.timer
# systemctl --user enable charging-notifier.service

echo "Charging Notifier installation completed."