#!/bin/sh
yum check-update
yum install -y epel-release
yum check-update
yum install -y sudo wget git kbd vim vim-common strace ltrace git net-tools lsof python2-pip python3-pip dkms make bzip2 curl bind-utils openssh nmon htop gzip coreutils dos2unix util-linux iptables jq less nmap-ncat parallel sed grep sqlite ftp tzdata python3-virtualenv postgresql-devel python36 python36-devel colordiff findutils nfs-utils ntfs-3g pigz freerdp xrdp samba samba-client cifs-utils openssl pv subversion tar telnet tcpdump wireshark traceroute usbutils whois xz showmount

# some missing packages from CentOS 8 but that might exist elsewhere
yum install -y bmon vconfig python-virtualenvwrapper python3-virtualenvwrapper libpcap-devel libpcap

# set permanently the keyboard mapping
localectl set-keymap fr

# upgrade pip and install cool modules
pip install --upgrade pip
pip install csvkit pyinstaller

pip3 install --upgrade pip
pip3 install csvkit pyinstaller

# set up virtualenvwrapper
grep -i 'workon_home' ~/.bashrc ||  echo 'export WORKON_HOME=~/.virtualenvs' >> ~/.bashrc
grep -i 'virtualenvwrapper.sh' ~/.bashrc ||  echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc

# install vmware tools
yum install -y unzip patch gcc glibc-headers kernel-devel "kernel-devel-uname-r == $(uname -r)" kernel-headers perl fuse
cd /opt 
git clone https://github.com/rasa/vmware-tools-patches.git &&\
cd vmware-tools-patches && ./setup.sh && ./download-tools.sh latest && ./untar-and-patch-and-compile.sh

# setting timezone
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# cleaning yum caches
yum clean all

# disabled ununsed services
systemctl stop rpcbind.socket && systemctl stop rpcbind && systemctl disable rpcbind && systemctl disable rpcbind.socket