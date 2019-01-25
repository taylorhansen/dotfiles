#!/usr/bin/env sh
# creates symlinks to the dotfiles in this folder

# create backup folder
olddir=~/dotfiles-old
echo "Creating backup dotfiles folder $olddir"
mkdir -p $olddir

# make all those symlinks
dir=~/dotfiles
files='bashrc bash_aliases vimrc gitconfig'
echo 'Creating symlinks for:'
cd $dir
for file in $files
do
	echo .$file
	if [ -f ~/.$file -o -d ~/.$file ]
	then
		mv ~/.$file $olddir/.$file
	fi
	ln -s $dir/$file ~/.$file
done
echo 'Done making symlinks'
