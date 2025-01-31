import subprocess
import psutil
import configparser

def send_notification(title, message, sound_file):
    
    # Send notification
    subprocess.run(['notify-send', title, message])

    # Play sound
    subprocess.run(['aplay', f"/usr/share/sounds/charging-notifier/{sound_file}"])
    # print(f"Playing sound: {sound_file}")

def get_battery_status():
    battery = psutil.sensors_battery()
    percent = battery.percent
    charging = battery.power_plugged
    return percent, charging

def main():
    config = configparser.ConfigParser()
    config.read('/usr/libexec/charging-notifier/config.ini')

    charging_threshold = int(config['DEFAULT']['charging_threshold'])
    discharging_threshold = int(config['DEFAULT']['discharging_threshold'])

    percent, charging = get_battery_status()

    if percent > charging_threshold and charging:
        send_notification(
            "Battery Warning!🔋",
            f"Battery is charging and at {int(percent)}%",
            "charged-notify.wav"
        )

    elif percent < discharging_threshold and not charging:
        send_notification(
            "Battery Warning!🪫",
            f"Battery is discharging and at {int(percent)}%",
            "discharged-notify.wav"
        )

if __name__ == '__main__':
    main()
