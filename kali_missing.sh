#!/bin/sh
apt update
apt install -y $(cat "./kali_missing_packages.txt")