#!/usr/bin/env bash
# used by me for setting up my Linux installation

if [ "$EUID" -ne 0 ]
then
    echo 'Please run as root'
    exit 1
fi

# you probably shouldn't execute this on other linux distros
# but if you really want to, just hit y
distro='Ubuntu 18.04.1'
if [ "$(lsb_release -d | cut -f2)" != "$distro" ]
then
    echo "Error: not using $distro"
    read -p "Are you sure you want to continue? [y/N] " response
    # FIXME: still works if press enter
    if [[ ! $response = y* ]]
    then
        exit
    fi
fi

# setup options
# TODO: command line args?

# llvm and clang
install_llvm=true
# dev resources like git, python, etc.
install_dev=true
# themes and other misc customizations
install_theme=true

echo
echo 'Adding repositories'
echo

repos=

if [ $install_llvm -o $install_dev ]
then
    repos="$repos ubuntu-toolchain-r/test"
fi

if [ $install_theme ]
then
    repos="$repos daniruiz/flat-remix"
fi

# add repositories if not already added
for repo in $repos
do
    if ! grep -q "^deb .*$repo" /etc/apt/sources.list /etc/apt/sources.list.d/*
    then
        sudo add-apt-repository -y ppa:$repo
    fi
done
sudo apt update

echo
echo 'Installing packages'
echo

to_install=

if [ $install_llvm ]
then
    llvm_version=6.0
    to_install="$to_install llvm-$llvm_version-dev clang-$llvm_version \
        libclang-$llvm_version"
fi

if [ $install_dev ]
then
    to_install="$to_install git subversion python-dev python3-dev cmake \
        libz-dev doxygen graphviz build-essential"
fi

if [ $install_theme ]
then
    to_install="$to_install htop sl arc-theme flat-remix gnome-tweak-tool"
fi

if [ "$to_install" ]
then
    sudo apt install -y $to_install
fi

echo
echo 'Performing post-initialization setup'
echo

if [ $install_llvm ]
then
    echo 'Setting up clang'
    # since we're installing clang, we need to override any preinstalled version
    sudo update-alternatives --install /usr/bin/clang clang \
        /usr/bin/clang-$llvm_version 100
    sudo update-alternatives --install /usr/bin/clang++ clang++ \
        /usr/bin/clang++-$llvm_version 100
fi

if [ $install_theme ]
then
    echo 'Setting up theme'
    dconf write /org/gnome/desktop/interface/enable-animations "true"
    dconf write /org/gnome/desktop/interface/gtk-theme "'Arc-Darker'"
    dconf write /org/gnome/desktop/interface/cursor-theme "'DMZ-White'"
    dconf write /org/gnome/desktop/interface/icon-theme "'Flat-Remix-Dark'"

    echo 'Changing terminal colors to cooler ones'
    # need to figure out what terminal profile we're using
    profile=$(dconf read /org/gnome/terminal/legacy/profiles:/default | \
            sed "s/'//g")
    prefix="/org/gnome/terminal/legacy/profiles:/:$profile"
    dconf write $prefix/use-theme-colors 'false'
    dconf write $prefix/foreground-color "'rgb(235,219,178)'"
    dconf write $prefix/background-color "'rgb(40,40,40)'"

    echo 'Swapping caps lock with escape'
    dconf write /org/gnome/desktop/input-sources/xkb-options \
        "['caps:swapescape']"

    if ! sudo grep -q '^Defaults[[:blank:]]\+.*insults.*' /etc/sudoers
    then
        echo 'Enabling sudo insults'
        sudo sed -i '$aDefaults\tinsults' /etc/sudoers
    fi
fi

# create dotfile symlinks
echo
./make-symlinks.sh

# build vim from source
if [ $install_dev ]
then
    echo
    sudo ./build-vim.sh
fi

echo '
Done!
Reboot may be required to see some changes
Some other things that may need to be done:
* install proprietary gpu drivers and/or cpu microcode
* disable secure boot in the bios so it can handle the non-free software
* choose a cool wallpaper
* update old packages'
