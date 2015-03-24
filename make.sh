#!/bin/bash
#Installs the dotfiles within this folder to the current user.

#Names of folders:
# This folder
thisdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# Folder containing new dotfiles
dotfiles="${thisdir}/files"
# Folder containing old dotfiles
olddir="${thisdir}.old"
# Folder containing system specific files
specificfiles="${thisdir}/system-specific"

echo "Running preliminary setup..."
source ${thisdir}/setup.sh
echo "Setup done."
echo ""

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

