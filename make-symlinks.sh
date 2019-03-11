#!/usr/bin/env bash
# creates symlinks to the dotfiles in this folder

# create backup folder
olddir=~/dotfiles-old
echo "Creating backup dotfiles folder $olddir"
mkdir -p $olddir

# make all those symlinks
dir=~/dotfiles
typeset -A file_locs=( \
[bashrc]=~ \
[bash_aliases]=~ \
[gitconfig]=~ \
[nethackrc]="$HOME/snap/nethack/67" \
[vimrc]=~ )

echo 'Creating symlinks for:'
cd $dir
for file in ${!file_locs[@]}
do
    loc=${file_locs[$file]}
    echo ".$file in $loc"
    if [ -f $loc/.$file -o -d $loc/.$file ]
    then
        mv $loc/.$file $olddir/.$file
    fi
    ln -s $dir/$file $loc/.$file
done
echo 'Done making symlinks'
