#!/bin/bash

#variable declarations:
MINECRAFT_DATA='/minecraft/data'
MINECRAFT_CODE='/minecraft'
SERVER_STDIN_FIFO='/tmp/server_stdin.fifo'
SERVER_JAR="$MINECRAFT_CODE/server.jar"
EULA_TEMPLATE="$MINECRAFT_CODE/eula.txt"

set -e

mkdir -p "$MINECRAFT_DATA"
cd "$MINECRAFT_DATA"
echo "starting minecraft in directory $(pwd)..."

if [ ! -e "eula.txt" ]; then 
    echo "eula does not exist. Copying template."
    cp "$EULA_TEMPLATE" ./
fi

#create fifo / pipe to be used as stdin for server
rm -f "$SERVER_STDIN_FIFO"
mkfifo "$SERVER_STDIN_FIFO"

#preserve path to stdin 
REAL_STDIN=`readlink /proc/self/fd/0` #shitty
exec_stdin_pump() {
  exec cat - < "$REAL_STDIN" >> "$SERVER_STDIN_FIFO"
  exit 1
}
exec_stdin_pump & # this closes the real stdin for whatever reason... recovering using "REAL_STDIN" variable

exec java -Xmx2048M -Xms2048M -jar "$SERVER_JAR" <"$SERVER_STDIN_FIFO"
