#!/bin/sh
yum check-update
yum install -y epel-release
yum check-update
yum install -y $(cat "./centos_rhel_packages.txt")

# some missing packages from CentOS 8 but that might exist elsewhere
yum install -y vconfig python-virtualenvwrapper python3-virtualenvwrapper

# set permanently the keyboard mapping
localectl set-keymap fr

# customizing bashrc
echo "export LS_OPTIONS='--color=auto'" >> ~/.bashrc
echo 'eval "`dircolors`"' >> ~/.bashrc
echo alias ls='ls $LS_OPTIONS' >> ~/.bashrc

# upgrade pip and install cool modules
pip install --upgrade pip
pip install csvkit pyinstaller

pip3 install --upgrade pip
pip3 install csvkit pyinstaller

# set up virtualenvwrapper
grep -i 'workon_home' ~/.bashrc ||  echo 'export WORKON_HOME=~/.virtualenvs' >> ~/.bashrc
grep -i 'virtualenvwrapper.sh' ~/.bashrc ||  echo 'source /bin/virtualenvwrapper.sh' >> ~/.bashrc

# install vmware tools
yum install -y unzip patch gcc glibc-headers kernel-devel "kernel-devel-uname-r == $(uname -r)" kernel-headers perl fuse3
yum install -y open-vm-tools &&\
echo ".host:/PartageVM     $HOME/PartageVM    fuse.vmhgfs-fuse       defaults,auto,nofail,allow_other    0       0" >> /etc/fstab

# setting timezone
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# cleaning yum caches
yum clean all

# disabled ununsed services
systemctl stop rpcbind.socket && systemctl stop rpcbind && systemctl mask rpcbind && systemctl mask rpcbind.socket
systemctl stop postfix && systemctl mask postfix
systemctl stop chronyd && systemctl mask chronyd
systemctl stop dnsmasq && systemctl mask dnsmasq
systemctl stop avahi-daemon.socket avahi-daemon.service && systemctl mask avahi-daemon.socket avahi-daemon.service
