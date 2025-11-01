#!/usr/bin/env bash
set -xe

apt update
apt install -y $(cat "./kali_missing_packages.txt") || (echo "[!] issue while installing required packages !" && exit 1)
apt clean && apt autoclean
