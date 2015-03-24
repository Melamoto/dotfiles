#!/bin/bash

# Get the name of this folder
thisdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# Folder containing new dotfiles
dotfiles="${thisdir}/files"
# Folder containing old dotfiles
olddir="${thisdir}.old"
# Folder containing system specific files
specificfiles="${thisdir}/system-specific"

echo "Running preliminary setup..."

# Initialize vim plugin submodules
echo "Initialize vim plugin submodules..."
git submodule init
git submodule update
echo "Done."

# Create backup and swap folders for vim
echo "Creating backup and swap folders for vim..."
mkdir -p ~/.vim-backup
mkdir -p ~/.vim-swap
echo "Done."

# Create empty source files for system-specific configurations if none exist
echo "Spawning system specific config files..."
touch ${specificfiles}/vimrc
touch ${specificfiles}/bashrc
echo "Done."

for sf in $(ls $specificfiles/) ; do
  if [ ! $sf == "README.md" ] ; then
    dotname=".${sf}-specific"
    sourcename="${specificfiles}/${sf}"
    destname="${HOME}/${dotname}"
    if [ ! -e $destname ] ; then
      echo "Symlinking specific ${sf}..."
      ln -s $sourcename $destname
      echo "Done."
    fi
  fi
done

echo "Setup done."
echo ""

echo "Installing new dotfiles..."

echo "Creating folder to contain old dotfiles..."
mkdir -p $olddir
echo "Done."

for df in $(ls $dotfiles/) ; do
  dotname=".$df"
  sourcename="${dotfiles}/${df}"
  destname="${HOME}/${dotname}"
  if [ -e $destname ] ; then
    backupname="${olddir}/${df}"
    echo "Backing up ${destname}..."
    mv $destname $backupname
  fi
  echo "Symlinking ${df}..."
  ln -s $sourcename $destname
  echo "Done."
done

echo "Dotfiles installed."

