#!/usr/bin/env sh

if cd dell-bios-fan-control
then
    git checkout master
    git pull origin master
else
    git clone https://github.com/TomFreudenberg/dell-bios-fan-control
    cd dell-bios-fan-control
fi
make
cd ..

sudo ln -f disable-bios-fan /etc/init.d/disable-bios-fan
sudo update-rc.d disable-bios-fan start 2
