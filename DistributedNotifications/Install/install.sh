#!/bin/sh
#
# install.sh
#
# Created by Miralem Cebic on 12/02/16.
#
# Copyright © 2016 Miralem Cebic. All rights reserved.
#
# The script installing the two agents
#

CURRENTDIR=`pwd`
VERSION="0.0.1"


if ! [ -f "$CURRENTDIR/uninstall.sh" ]
then
echo "--> Can not find: uninstall.sh in: $CURRENTDIR"
exit 12
fi

"$CURRENTDIR/uninstall.sh"


echo "\n"
echo "--------------"
echo "->START INSTALLATION OF LaunchAgent-Daemon & LaunchDaemon-Daemon"


if ! [ -d "/Library/Application Support/MCC-DistributedNotifications" ]
then
sudo mkdir "/Library/Application Support/MCC-DistributedNotifications"
echo "--> Created Directory /Library/Application Support/MCC-DistributedNotifications"
fi


echo "\n"
echo "--------------"
echo "->CHECK IF PLIST FILES ARE AVAILABLE"

if ! [ -f "$CURRENTDIR/de.miralem-cebic.launchagent.plist" ]
then
echo "--> Can not find: de.miralem-cebic.launchagent.plist in: $CURRENTDIR"
exit 22
fi

if ! [ -f "$CURRENTDIR/de.miralem-cebic.launchdaemon.plist" ]
then
echo "--> Can not find: de.miralem-cebic.launchdaemon.plist in: $CURRENTDIR"
exit 23
fi


echo "\n"
echo "--------------"
echo "->CHECK IF APPS ARE AVAILABLE"

if ! [ -d "$CURRENTDIR/LaunchAgent-Daemon.app/" ]
then
echo "--> Can not find: LaunchAgent-Daemon.app in: $CURRENTDIR"
exit 32
fi

if ! [ -d "$CURRENTDIR/LaunchDaemon-Daemon.app/" ]
then
echo "--> Can not find: LaunchDaemon-Daemon.app in: $CURRENTDIR"
exit 33
fi

echo "\n"
echo "--------------"
echo "->COPY PLIST FILES"

sudo cp "$CURRENTDIR/de.miralem-cebic.launchagent.plist" "/Library/LaunchAgents/de.miralem-cebic.launchagent.plist"
sudo cp "$CURRENTDIR/de.miralem-cebic.launchdaemon.plist" "/Library/LaunchDaemons/de.miralem-cebic.launchdaemon.plist"

echo "\n"
echo "--------------"
echo "->COPY APPS"

sudo cp -R "$CURRENTDIR/LaunchAgent-Daemon.app" "/Library/Application Support/MCC-DistributedNotifications/LaunchAgent-Daemon.app"
sudo cp -R "$CURRENTDIR/LaunchDaemon-Daemon.app" "/Library/Application Support/MCC-DistributedNotifications/LaunchDaemon-Daemon.app"

echo "\n"
echo "--------------"
echo "->STARTING AGENTS"

sudo launchctl load -w "/Library/LaunchAgents/de.miralem-cebic.launchagent.plist"
sudo launchctl load -w "/Library/LaunchDaemons/de.miralem-cebic.launchdaemon.plist"

echo "\n"
echo "--------------"
echo "->END INSTALLATION OF LaunchAgent-Daemon & LaunchDaemon-Daemon"
