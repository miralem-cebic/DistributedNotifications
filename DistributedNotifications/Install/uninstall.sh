#!/bin/sh
#
# uninstall.sh
#
# Created by Miralem Cebic on 12/02/16.
#
# Copyright © 2016 Miralem Cebic. All rights reserved.
#
# The script uninstalling the two agents
#

echo "\n"
echo "--------------"
echo "->START UNINSTALLATION OF LaunchAgent-Daemon & LaunchDaemon-Daemon"

if launchctl list "/Library/LaunchAgents/de.miralem-cebic.launchagent.plist" &> /dev/null; then
echo "--> Unloaded de.miralem-cebic.launchagent.plist"
sudo launchctl unload "/Library/LaunchAgents/de.miralem-cebic.launchagent.plist"
fi

if launchctl list "/Library/LaunchDaemons/de.miralem-cebic.launchdaemon.plist" &> /dev/null; then
echo "--> Unloaded de.miralem-cebic.launchdaemon.plist"
sudo launchctl unload "/Library/LaunchDaemons/de.miralem-cebic.launchdaemon.plist"
fi

echo "\n"
echo "--------------"
echo "->REMOVING DIRECTORY at /Library/Application Support/MCC-DistributedNotifications"

sudo rm -Rf "/Library/Application Support/MCC-DistributedNotifications"