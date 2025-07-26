#!/bin/bash

# Prompt user for threshold values
read -p "Enter charging threshold percentage: " charging_threshold
read -p "Enter discharging threshold percentage: " discharging_threshold

# Create installation directory
sudo mkdir -p /usr/libexec/charging-notifier

# Create virtual environment
sudo python3 -m venv /usr/libexec/charging-notifier/venv

# Activate virtual environment and install dependencies
sudo /usr/libexec/charging-notifier/venv/bin/pip install -r requirements.txt

# Update config.ini with user-provided values
sed -i "s/charging_threshold = .*/charging_threshold = $charging_threshold/" src/config.ini

# Copy source files
sudo cp src/* /usr/libexec/charging-notifier/

# Copy systemd files
mkdir -p ~/.config/systemd/user
cp systemd/charging-notifier.service ~/.config/systemd/user/
cp systemd/charging-notifier.timer ~/.config/systemd/user/

# Copy sound files
sudo mkdir -p /usr/share/sounds/charging-notifier
sudo cp sounds/* /usr/share/sounds/charging-notifier/

# Enable and start services
systemctl --user daemon-reload
systemctl --user enable charging-notifier.timer
systemctl --user start charging-notifier.timer

# Clean up any temporary files
rm -f /tmp/charging-notifier.service

echo "Charging Notifier installation completed."