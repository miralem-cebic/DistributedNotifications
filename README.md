# Distributed Notifications
![MacDown logo](DistributedNotifications/LaunchAgent-Daemon/Assets.xcassets/AppIcon.appiconset/Icon_128x128.png)
![MacDown logo](DistributedNotifications/LaunchDaemon-Daemon/Assets.xcassets/AppIcon.appiconset/Icon_128x128.png)

One daemon is a LaunchAgent daemon, who runs as an Agent in OS X status bar.

The second daemon is running in the background as a LaunchDaemon.

The goal is that the two daemons communicate trouth Notification with each other.
Also the first Daemon should display a UI in OS X Login Window.

## How To Build
Clone the project on a OS X 10.11 machine via terminal `git clone https://github.com/RabbitMC/DistributedNotifications.git`.

Open *DistributedNotifications.xcodeproj*

You will get two Targets: 

* LaunchAgent-Daemon
* LaunchDaemon-Daemon

There is also a DaemonAggregator Scheme.

Build the project using the Aggregator Scheme named *Daemons-Aggregater* to keep it simple.

The result of the Build will be generate a folder on your Dektop, by a build phases script in the Aggregator Scheme.

After the Xcode build navigate to your Desktop. You will find a new directory, named *Daemon-Builds*. In this dir you can execute the *install.sh* script by `sudo /bin/sh install.sh`.

It will automaticly install the Agents and start them up.

## DistributedNotifications
Distributed Notifications using Core Foundation API: **CFNotificationCenterGetDistributedCenter** 

There are many ways for objects to communicate with one another in Cocoa:

There is, of course, sending a message directly. There are also the target-action, delegate, and callbacks, which are all loosely-coupled, one-to-one design patterns. KVO allows for multiple objects to subscribe to events, but it strongly couples those objects together. Notifications, on the other hand, allow messages to be broadcast globally, and intercepted by any object that knows what to listen for.

Each application manages its own `NSNotificationCenter` instance for infra-application pub-sub. But there is also a lesser-known Core Foundation API, `CFNotificationCenterGetDistributedCenter` that allows notifications to be communicated system-wide as well.

To listen for notifications, add an observer to the distributed notification center by specifying the notification name to listen for, and a function pointer to execute each time a notification is received:

	static void Callback(CFNotificationCenterRef center,
                     void *observer,
                     CFStringRef name,
                     const void *object,
                     CFDictionaryRef userInfo)
	{
    	// ...
	}

	CFNotificationCenterRef distributedCenter =
	    CFNotificationCenterGetDistributedCenter();
	
	CFNotificationSuspensionBehavior behavior =
	        CFNotificationSuspensionBehaviorDeliverImmediately;
	
	CFNotificationCenterAddObserver(distributedCenter,
	                                NULL,
	                                Callback,
	                                CFSTR("notification.identifier"),
	                                NULL,
	                                behavior);

Sending a distributed notification is even simpler; just post the identifier, object, and user info:

	void *object;
	CFDictionaryRef userInfo;
	
	CFNotificationCenterRef distributedCenter =
	    CFNotificationCenterGetDistributedCenter();
	
	CFNotificationCenterPostNotification(distributedCenter,
	                                     CFSTR("notification.identifier"),
	                                     object,
	                                     userInfo,
	                                     true);

Of all of the ways to link up two applications, distributed notifications are by far the easiest. It wouldn’t be a great idea to use them to send large payloads, but for simple tasks like synchronizing preferences or triggering a data fetch, distributed notifications are perfect.

source: <br />
[nshipster - inter-process-communication](http://nshipster.com/inter-process-communication/)

### Other References

* [Apple PreLoginAgents](https://developer.apple.com/library/mac/samplecode/PreLoginAgents/Introduction/Intro.html#//apple_ref/doc/uid/DTS10004414)
* [Apple SampleD](https://developer.apple.com/library/mac/samplecode/SampleD/Introduction/Intro.html)
* [Apple TN2083 'Daemons and Agents'](https://developer.apple.com/library/mac/technotes/tn2083/_index.html)
* [Apple 'Creating Launch Daemons and Agents'](https://developer.apple.com/library/mac/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html#//apple_ref/doc/uid/10000172i-SW7-BCIEDDBJ)
* [Stackoverflow](http://stackoverflow.com/questions/6968677/cfnotificationcenter-usage-examples)
* [Icons](http://iconfactory.com/downloads/freeware/agap/)