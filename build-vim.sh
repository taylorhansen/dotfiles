#!/usr/bin/env sh
# compiles vim from source (to get ALL the features) and sets up YouCompleteMe
# should be run with sudo
# assumes that make-symlinks.sh was already run so that $HOME/.vimrc exists

echo 'Removing current installation of vim'
sudo apt remove -y gvim* vim*

echo 'Installing dependencies'
sudo apt install build-essential ncurses-dev golang python-dev python3-dev

cd $HOME
if cd vim
then
    echo 'Updating vim source'
    git checkout master
    git pull origin master
else
    echo 'Cloning vim source'
    git clone https://github.com/vim/vim.git
    cd vim
fi

echo 'Building vim from source'
./configure --with-features=huge --enable-multibyte --enable-pythoninterp=yes \
    --enable-python3interp=yes --enable-cscope --prefix=/usr/local
# use parallelism to speed it up
$num_cores="$(grep -c ^processor /proc/cpuinfo)"
make -j$num_cores

echo 'Installing vim'
sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 100
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 100
sudo update-alternatives --set vi /usr/local/bin/vim

echo 'Installing vim plugins'
# remove vim home directory
# vimrc will create a fresh one automatically
if [ -d "$HOME/.vim" ]
then
    # sudo is required here because YCM likes to make it harder to delete
    sudo rm -rf $HOME/.vim
fi
# vimrc automatically installs everything, but has a hit-enter prompt afterwards
# throwing this newline into stdin makes it skip that prompt
echo '' | vim +qa

echo Done. Existing terminals may need to run \'hash -r\' to find the new vim binary.
