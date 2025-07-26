#!/bin/bash

# Check if script is run with sudo
if [ "$EUID" -eq 0 ]; then
    echo "Error: Do not run this script with sudo!"
    echo "The script will use sudo internally when needed."
    exit 1
fi

# Check if python3-venv is installed
if ! python3 -m venv --help &> /dev/null; then
    echo "python3-venv is not installed. Installing it now..."
    
    # Detect package manager and install python3-venv
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y python3-venv
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y python3-venv
    elif command -v yum &> /dev/null; then
        sudo yum install -y python3-venv
    elif command -v pacman &> /dev/null; then
        sudo pacman -S python-venv
    else
        echo "Could not detect package manager. Please install python3-venv manually."
        exit 1
    fi
fi

# Prompt user for threshold values
read -p "Enter charging threshold percentage: " charging_threshold
read -p "Enter discharging threshold percentage: " discharging_threshold

# Create installation directory
sudo mkdir -p /usr/libexec/charging-notifier

# Create virtual environment (as root, but it will be accessible)
sudo python3 -m venv /usr/libexec/charging-notifier/venv

# Check if virtual environment was created successfully
if [ ! -f "/usr/libexec/charging-notifier/venv/bin/python" ]; then
    echo "Error: Virtual environment creation failed!"
    echo "Please ensure python3-venv is properly installed."
    exit 1
fi

# Install dependencies in virtual environment
sudo /usr/libexec/charging-notifier/venv/bin/pip install -r requirements.txt

# Check if pip install was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to install dependencies!"
    exit 1
fi

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