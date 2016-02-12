# DistributedNotifications
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

[source: nshipster - inter-process-communication](http://nshipster.com/inter-process-communication/)