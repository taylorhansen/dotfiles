#!/usr/bin/env sh
# sets up everything and runs all the scripts in this directory

# you probably shouldn't execute this on other linux distros
echo 'Checking distro'
distro='Ubuntu 17.10'
if [ "$(lsb_release -d | cut -f2)" != "$distro" ]
then
    echo "Error: not using $distro!"
    exit 1
fi

# install a bunch of packages and update existing ones
echo 'Installing required packages'
repos='ubuntu-toolchain-r/test daniruiz/flat-remix'
for repo in $repos
do
    if ! grep -q "^deb .*$repo" /etc/apt/sources.list /etc/apt/sources.list.d/*
    then
        sudo add-apt-repository -y ppa:$repo
    fi
done
sudo apt update
llvm_version=5.0
sudo apt install -y git htop llvm-$llvm_version-dev clang-$llvm_version \
    libclang-$llvm_version-dev sl arc-theme flat-remix gnome-tweak-tool \
    python-dev python3-dev cmake libz-dev
sudo update-alternatives --install /usr/bin/clang clang \
    /usr/bin/clang-$llvm_version 100
sudo update-alternatives --install /usr/bin/clang++ clang++ \
    /usr/bin/clang++-$llvm_version 100

echo 'Changing theme'
dconf write /org/gnome/desktop/interface/enable-animations "true"
dconf write /org/gnome/desktop/interface/gtk-theme "'Arc-Darker'"
dconf write /org/gnome/desktop/interface/cursor-theme "'DMZ-White'"
dconf write /org/gnome/desktop/interface/icon-theme "'Flat-Remix-Dark'"

echo 'Changing terminal colors to cooler ones'
# the sed part removes the quotes
profile=$(dconf read /org/gnome/terminal/legacy/profiles:/default | \
        sed "s/'//g")
dconf write /org/gnome/terminal/legacy/profiles:/:$profile/use-theme-colors \
    'false'
# slightly tan text, slightly gray-ish background
dconf write /org/gnome/terminal/legacy/profiles:/:$profile/foreground-color \
    "'rgb(235,219,178)'"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile/background-color \
    "'rgb(40,40,40)'"

echo 'Swapping caps lock with escape'
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"

echo 'Configuring Git'
git config --global alias.adog 'log --all --decorate --oneline --graph'

echo 'Enabling sudo insults'
if ! sudo grep -q '^Defaults[[:blank:]]\+.*insults.*' /etc/sudoers
then
    sudo sed -i '$aDefaults\tinsults' /etc/sudoers
fi

# create dotfile symlinks
./make-symlinks.sh

# build vim from source
sudo ./build-vim.sh

echo 'Done
Reboot may be required to see changes
Some other things that may need to be done:
* install proprietary drivers and/or cpu microcode
* disable secure boot in the bios so it can handle the non-free software
* choose a cool wallpaper
* update old packages'
