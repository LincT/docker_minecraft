#!/bin/bash

# VARIABLE DECLARATIONS:

MINECRAFT_ROOT='/minecraft'

#adapted for 1.18. no log4j separate patch needed for 1.18.1+

MINECRAFT_SERVER_URL='https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar'
#MINECRAFT_SERVER_URL='https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar'
SERVER_INSTALLER_FILE_NAME='server.jar'

# Error out of script on any errors
set -e

# make minecraft root if not exists
mkdir -p "$MINECRAFT_ROOT"

# change to directory
cd "$MINECRAFT_ROOT"

# downloaded needed server downloader and installer
wget -O "$SERVER_INSTALLER_FILE_NAME" "$MINECRAFT_SERVER_URL"

# download and install minecraft server
# vanilla minecraft doesn't need to run installation, run same server file to populate eula, then overwrite
java -jar "$SERVER_INSTALLER_FILE_NAME" #--installServer new-install

# accept EULA
echo 'eula=true' > eula.txt
