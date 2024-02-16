# PiEvilTwin Portable Access Point

# A fake credential harvesting rogue captive portal for Orange Pi Zero 3 with Ubuntu

I do NOT take any responsibility for your actions while using any material provided from this repository.
Performing attacks on public users is illegal and should require permission from all users within the radius of the network.

Software:

Balena Etcher: 
https://www.balena.io/etcher/

Ubuntu Jammy Server Linux 6.1.31
http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service-and-support/Orange-Pi-Zero-3.html


Fresh install of Ubuntu Server:
Flash the Ubuntu Image to the Orange Pi using Etcher OR follow the steps below if you are using a linux OS to image the SD Card:

Insert the SD Card into the Pi and ssh to the new system with the following details:

```
username: orangepi
password: orangepi
```

Please ensure you regenerate the SSH keys and update the password, otherwise you will be hacked.

```
sudo su
apt update -y && apt upgrade -y
passwd orangepi
exit

This is performed differently on each system.

Once you've done this, reconnect using your new password, install dependencies and run the install script:


```
sudo apt-get update
sudo apt-get install -y git php dnsmasq dnsmasq-base macchanger hostapd
git clone https://github.com/ingcarrasco/OrangePiZero3iEvilTwin
cd OrangePiZero3iEvilTwin
chmod +x install.sh
sudo ./install.sh
sudo reboot
```
During installation, macchanger may ask whether or not MAC addresses should be changed automatically - choose "No". The startup script will perform this task more reliably.

If you receive a similar message with "Restart services during package upgrades without asking?" - choose "Yes".
This is required for cron to work.

After the reboot, wait 30 seconds and then look for an access point named "Google WiFi." 

Connecting to it from an Apple, Android or Windows device should automatically bring up a captive portal login screen.
The Windows captive portal is a bit harder to introduce properly. (BETA)
It requires a folder called 'redirect' with it's own 'index.html' file redirecting to the root website index.html

Credentials are logged in `/var/www/html/usernames.txt`.
Website data will be able to be modified under `/var/www/html`

To use an external WiFi Adapter for better range, please change the
'wlan0' value in the following files:

```
hostapd.conf
OrangePiZero3iEvilTwin.sh 
```

To:

Your WiFi adapter interface name e.g 'wlan1' without quotes before running the install script.

I do NOT take any responsibility for your actions while using any material provided from this repository.
Performing attacks on public users is illegal and should require permission from all users within the radius of the network.
