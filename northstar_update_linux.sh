#!/bin/bash

# The linux / Wine intall location - change as required.
install_location="/home/vibri/Games/ea-app/drive_c/Program Files/Titanfall2"

# Get the latst version of the zip file
file="$(
curl -s https://api.github.com/repos/R2Northstar/Northstar/releases/latest \
| grep browser_download_url \
| sed -e 's/      "browser_download_url": "//' \
| sed -e 's/"//'
)"

aria2c ${file} -d "${install_location}"	# Download the file

# Check if backup exists if not backup original .exe file.
if [ -f "${install_location}/Titanfall2.exe.bak" ];
then
 echo 'Backup already exists'
 else
 echo 'Created backup Titanfall2.exe.bak'
 cp "${install_location}/Titanfall2.exe" "${install_location}/Titanfall2.exe.bak"
fi

7z x -y "${install_location}/$(echo ${file} | sed 's;^.*/;;g')" -o"${install_location}"

# Replace Titanfall2 executable - means ea launcher will run this one under wine.
cp "${install_location}/NorthstarLauncher.exe" "${install_location}/Titanfall2.exe"
