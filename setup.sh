#!/bin/bash

# Get the name of this folder
thisdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# Folder containing system specific files
specificfiles="${thisdir}/system-specific"

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

