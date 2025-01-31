### Charging Notifier

Charging Notifier is a Python-based utility designed to monitor your laptop's battery status and provide timely notifications to help you maintain optimal battery health. This tool alerts you when your battery is charging or discharging beyond user-defined thresholds, ensuring you are always aware of your battery's status and can take appropriate action to prolong its lifespan.

### Features

- **Customizable Thresholds:** Set your own charging and discharging thresholds to receive notifications tailored to your preferences.
- **Battery Status Monitoring:** Continuously monitors the battery percentage and charging status.
- **Desktop Notifications:** Sends desktop notifications when the battery exceeds the charging threshold or drops below the discharging threshold.
- **Audio Alerts:** Plays a sound notification to draw your attention to critical battery status changes.
- **Systemd Integration:** Utilizes systemd services and timers to run the notifier script at regular intervals, ensuring consistent monitoring without manual intervention.
- **User-Friendly Installation:** Easy-to-follow installation script that sets up the virtual environment, installs dependencies, and configures systemd services and timers.

### Tested Environment

- This utility has been tested on Fedora 41. It may work on other Linux distributions as well.

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/VelvetReek/charging-notifier.git
   cd charging-notifier
   ```

2. **Run the installation script:**

   ```bash
   ./scripts/install.sh
   ```

   **Note:** Do not use `sudo` to run the installation script as it creates a systemd service in user space.

3. **Set the desired battery levels:**

   During installation, you will be prompted to set the desired charging and discharging thresholds. The default values are 80% for charging and 35% for discharging.

   **Note:** You can change the battery levels later by editing the `config.ini` file located at

config.ini

or by running the `./scripts/modify.sh` script.

### Usage

Once installed, the Charging Notifier will automatically monitor your battery status and notify you when the thresholds are crossed. You do not need to manually start the service as it is managed by systemd.

### System Requirements

- Python 3.x
- Linux operating system with systemd
- `notify-send` and `aplay` utilities for notifications and audio alerts

### Contributing

Contributions are welcome! Please fork the repository and submit pull requests for any enhancements or bug fixes.

### License

This project is licensed under the MIT License.

### Contact

For any questions or support, please contact [yourname@yourdomain.com].

---

This README provides a comprehensive overview of the Charging Notifier project, highlighting its features, installation steps, usage, and other relevant information.
