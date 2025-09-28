#!/bin/sh
dnf check-update
dnf install -y epel-release
crb enable
dnf check-update
dnf install -y --best --allowerasing $(cat "./centos_rhel_packages.txt")

# set permanently the keyboard mapping
localectl set-keymap fr

# customizing bashrc
echo "export LS_OPTIONS='--color=auto'" >> ~/.bashrc
echo 'eval "`dircolors`"' >> ~/.bashrc
echo alias ls='ls $LS_OPTIONS' >> ~/.bashrc

# upgrade pip and install cool modules
pip install --upgrade pip virtualenvwrapper csvkit pyinstaller

# set up virtualenvwrapper
grep -i 'workon_home' ~/.bashrc ||  echo 'export WORKON_HOME=~/.virtualenvs' >> ~/.bashrc
grep -i 'virtualenvwrapper.sh' ~/.bashrc ||  echo 'source /bin/virtualenvwrapper.sh' >> ~/.bashrc

# install vmware tools
dnf install -y unzip patch gcc glibc-headers kernel-devel "kernel-devel-uname-r == $(uname -r)" kernel-headers perl fuse3
dnf install -y open-vm-tools &&\
echo ".host:/PartageVM     $HOME/PartageVM    fuse.vmhgfs-fuse       defaults,auto,nofail,allow_other    0       0" >> /etc/fstab

# setting timezone
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# cleaning dnf caches
dnf clean all

# disabled ununsed services
SERVICES_TO_DISABLE="rpcbind.socket rpcbind rpcbind.service rpc-statd-notify.service xrdp systemd-resolved.service lvm2-monitor.service mdadm-shutdown.service tor.service lvm2-lvmpolld.socket nfs-client.target remote-fs.target exim4.service exim4-base.timer fstrim.timer lm-sensors.service tftpd-hpa.service postfix chronyd dnsmasq avahi-daemon.socket avahi-daemon.service"
systemctl stop $SERVICES_TO_DISABLE
systemctl mask $SERVICES_TO_DISABLE
