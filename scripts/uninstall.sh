#!/bin/bash

# Stop and disable the systemd service and timer
systemctl --user stop charging-notifier.timer
systemctl --user stop charging-notifier.service
systemctl --user disable charging-notifier.timer
systemctl --user disable charging-notifier.service

# Remove the sound file
sudo rm -rf /usr/share/sounds/charging-notifier

# Remove systemd service and timer files
rm ~/.config/systemd/user/charging-notifier.service
rm ~/.config/systemd/user/charging-notifier.timer

# Remove the notifier script
sudo rm -rf /usr/libexec/charging-notifier

# Remove the python virtual environment
# sudo rm -rf /srv/charging-notifier

echo "Charging Notifier uninstallation completed."