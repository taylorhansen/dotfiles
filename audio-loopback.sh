#!/usr/bin/env bash

# credit to https://askubuntu.com/a/597019/733050

# redirects current audio input sources to audio output
# kill this script (ctrl-c) to stop listening
# use pavucontrol afterwards to configure input devices to listen to

# requires pactl package and a pulseaudio daemon to be running

set -e

module=$(pactl load-module module-loopback latency_msec=1)

cleanup()
{
    pactl unload-module $module
}

trap cleanup EXIT

sleep infinity
