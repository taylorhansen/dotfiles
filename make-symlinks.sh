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
[nethackrc]=~ \
[npmrc]=~ \
[vimrc]=~ )

echo 'Creating symlinks for:'
cd $dir
for file in ${!file_locs[@]}
do
    loc=${file_locs[$file]}

    # make sure the directory exists
    if [ -d $loc ]
    then
        echo "- .$file in $loc"

        # move old dotfile to backup folder
        if [ -f $loc/.$file ]
        then
            mv $loc/.$file $olddir/.$file
        fi

        # link dotfile location to this repository's dotfile
        ln -sf $dir/$file $loc/.$file
    else
        # $loc doesn't exist
        echo "- .$file in $loc (error: doesn't exist)"
    fi
done
echo 'Done making symlinks'
