# creates symlinks to the dotfiles in ~/dotfiles
dir=~/dotfiles
olddir=~/dotfiles-old
files="bashrc vim vimrc"
echo "Creating backup dotfiles folder $olddir"
mkdir -p $olddir
echo "Creating symlinks for:"
cd $dir
for file in $files
do
	echo "$file"
	if test -f ~/.$file || test -d ~/.$file
	then
		mv ~/.$file $olddir/.$file
	fi
	ln -s $dir/$file ~/.$file
done
