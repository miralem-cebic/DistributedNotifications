#set

DESTINATIONDIR="$HOME/Desktop/Daemon-Builds/"

if ! [ -d "$DESTINATIONDIR"]
then
rm -Rf $DESTINATIONDIR
fi

mkdir $DESTINATIONDIR

echo -e "\n\n---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||\n\n"

cd $PWD
cd Install
#ls -al
cp "de.miralem-cebic.launchagent.plist" "$DESTINATIONDIR/de.miralem-cebic.launchagent.plist"
cp "de.miralem-cebic.launchdaemon.plist" "$DESTINATIONDIR/de.miralem-cebic.launchdaemon.plist"
cp "install.sh" "$DESTINATIONDIR/install.sh"
cp "uninstall.sh" "$DESTINATIONDIR/uninstall.sh"

echo -e "\n\n---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||---|||\n\n"

cd $TARGET_BUILD_DIR
#ls -al
cp -R "LaunchAgent-Daemon.app" "$DESTINATIONDIR/LaunchAgent-Daemon.app"
cp -R "LaunchDaemon-Daemon.app" "$DESTINATIONDIR/LaunchDaemon-Daemon.app"
