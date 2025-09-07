#!/bin/sh
apt update
apt install -y $(cat "./debian_ubuntu_packages.txt")

# packages that do not exist in every debian-based distros (for instance: kali)
apt install -y mlocate

# set permanently the keyboard mapping
localectl set-keymap fr

# customizing bashrc
echo "export LS_OPTIONS='--color=auto'" >> ~/.bashrc
echo 'eval "`dircolors`"' >> ~/.bashrc
echo alias ls='ls $LS_OPTIONS' >> ~/.bashrc

# upgrade pip and install cool modules
pip2 install csvkit pyinstaller
pip3 install csvkit pyinstaller

# set up virtualenvwrapper
grep -i 'workon_home' ~/.bashrc ||  echo 'export WORKON_HOME=~/.virtualenvs' >> ~/.bashrc
grep -i 'virtualenvwrapper_python' ~/.bashrc || echo 'export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3' >> ~/.bashrc
grep -i 'virtualenvwrapper.sh' ~/.bashrc ||  echo 'source /usr/share/virtualenvwrapper/virtualenvwrapper.sh' >> ~/.bashrc

# install vmware tools and setup shared folder
apt install -y build-essential unzip patch gcc linux-headers-$(uname -r) perl psmisc zip fuse3
apt install -y open-vm-tools &&\
echo ".host:/PartageVM     $HOME/PartageVM    fuse.vmhgfs-fuse       defaults,auto,nofail,allow_other    0       0" >> /etc/fstab

# setting timezone
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# cleaning apt caches
apt autoclean && apt clean

# disabling unused services
SERVICES_TO_DISABLE="rpcbind.socket rpcbind rpcbind.service rpc-statd-notify.service xrdp systemd-resolved.service lvm2-monitor.service mdadm-shutdown.service tor.service lvm2-lvmpolld.socket nfs-client.target remote-fs.target exim4.service exim4-base.timer fstrim.timer lm-sensors.service tftpd-hpa.service"
systemctl stop $SERVICES_TO_DISABLE
systemctl mask $SERVICES_TO_DISABLE
