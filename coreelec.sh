#!/usr/bin/env sh
set -xe

opkg update
opkg remove ncat aria2
opkg install $(cat "./coreelec_packages.txt") || (echo "[!] issue while installing required packages !" && exit 1)

# disabling unused services
SERVICES_TO_DISABLE="connman-vpn.service nfs-idmapd.service nfs-mountd.service nfsdcld.service rpc-statd.service rpc-statd-notify.service rpcbind.service samba-config.service wsdd2.service vfd-clock.service rpcbind.socket"
systemctl stop $SERVICES_TO_DISABLE
systemctl mask $SERVICES_TO_DISABLE
