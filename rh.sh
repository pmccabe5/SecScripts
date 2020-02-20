#!/usr/bin/env bash
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo usermod -aG wheel $(whoami)
sudo yum remove garbagepackage -y
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
echo "Protocol 2" >> /etc/ssh/sshd_config
echo "LogLevel VERBOSE" >> /etc/ssh/sshd_config
sudo systemctl reload sshd.service
echo "net.ipv4.conf.all.send_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.icmp.ignore_bogus_error_responses=1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_source_route=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_source_route=0" >> /etc/sysctl.conf
echo "net.ipv4.icmp_echo_ignore_broadcasts=1" >> /etc/sysctl.conf
echo "alias net-pf-4 off # IPX" >> /etc/modules.conf
echo "alias net-pf-5 off # Appletalk" >> /etc/modules.conf
echo "alias net-pf-10 off # IPv6" >> /etc/modules.conf
echo "alias net-pf-12 off # Decnet" >> /etc/modules.conf 
sudo yum install net-tools nikto.noarch nmap wireshark clamav.x86_64 epel-release -y
sudo yum install fail2ban fail2ban-system -y
sudo yum update -y selinux-policy*
sudo systemctl start fail2ban
sudo systemctl enable fail2ban
echo "[sshd]" >> /etc/fail2ban/jail.d/sshd.local
echo "enabled = true" >> /etc/fail2ban/jail.d/sshd.local
echo "port = 22" >> /etc/fail2ban/jail.d/sshd.local
echo "logpath = /var/log/auth.log" >> /etc/fail2ban/jail.d/sshd.local
echo "maxretry = 3" >> /etc/fail2ban/jail.d/sshd.local
echo "bantime = 86400" >> /etc/fail2ban/jail.d/sshd.local
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
wget https://raw.github.com/emposha/Shell-Detector/master/shelldetect.py
python shelldetect.py -r True -d ./
echo "alias shells=\"python shelldetect.py -r True -d ./\"" >> ~/.bashrc
exec bash
git clone https://github.com/CISOfy/lynis
cd lynis; ./lynis audit system >> vulnscan.txt
echo "Script is done running, implement box firewall rules"