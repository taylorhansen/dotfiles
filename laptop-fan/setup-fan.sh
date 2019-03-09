#!/usr/bin/env sh

echo 'Detecting sensors'
sudo sensors-detect
sudo service module-init-tools restart

echo 'Calibrating fan'
sudo pwmconfig
sudo service fancontrol start

echo "Done!
You can edit your fancontrol settings by editing '/etc/fancontrol', then restartting the service with:

	sudo service fancontrol start

"
