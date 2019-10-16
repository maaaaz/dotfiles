#!/bin/sh
apt update
apt install -y sudo wget mlocate git kbd vim strace ltrace git net-tools lsof python-pip python3-pip dkms make bzip2 curl dnsutils openssh-server openssh-client bmon nmon htop gzip coreutils dos2unix util-linux iptables jq less nmap parallel sed grep sqlite3 ftp tzdata vlan python-virtualenv virtualenvwrapper libpq-dev libpcap-dev libssl-dev python3 python3-dev xxd colordiff findutils zutils nfs-common ntfs-3g pigz freerdp xrdp cifs-utils smbclient openssl subversion tar telnet tcpdump tshark traceroute vbindiff usbutils whois xz-utils

# set permanently the keyboard mapping
localectl set-keymap fr

# upgrade pip and install cool modules
pip2 install csvkit pyinstaller
pip3 install csvkit pyinstaller

# set up virtualenvwrapper
grep -i 'workon_home' ~/.bashrc ||  echo 'export WORKON_HOME=~/.virtualenvs' >> ~/.bashrc
grep -i 'virtualenvwrapper.sh' ~/.bashrc ||  echo 'source /usr/share/virtualenvwrapper/virtualenvwrapper.sh' >> ~/.bashrc

# install vmware tools
apt install -y build-essential unzip patch gcc linux-headers-$(uname -r) perl psmisc zip
cd /opt 
git clone https://github.com/rasa/vmware-tools-patches.git &&\
cd vmware-tools-patches && ./setup.sh && ./download-tools.sh latest && ./untar-and-patch-and-compile.sh

# setting timezone
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# cleaning apt caches
apt autoclean && apt clean