#!/usr/bin/env sh
# compiles vim from source (to get ALL the features) and sets up YouCompleteMe
# should be run with sudo
# assumes that make-symlinks.sh was already run so that $HOME/.vimrc exists

echo 'Removing current installation of vim'
sudo apt remove -y gvim* vim*

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
make -j4

echo 'Installing vim'
sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 100
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 100

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

echo 'Building YCM:'
cd $HOME/.vim/bundle/YouCompleteMe
python3 install.py --all

echo 'Done'
