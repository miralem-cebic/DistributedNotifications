//
//  main.m
//  LaunchDaemon-Daemon
//
//  Created by Miralem Cebic on 12/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Daemon.h"
#import "LogManager.h"

static void Callback(CFNotificationCenterRef center,
                     void *observer,
                     CFStringRef name,
                     const void *object,
                     CFDictionaryRef userInfo)
{
    [[LogManager sharedManager] logWithFormat:@"Recieved Notification from LaunchAgent"];

//    NSDictionary *userInfoDict = (__bridge NSDictionary *)userInfo;
    Daemon *daemon = [Daemon sharedDaemon];
    [daemon showAboutEmpirumAgentInformation];

}

static void addCFNotificationCenterObserver()
{
    CFNotificationCenterRef distributedCenter = CFNotificationCenterGetDistributedCenter();
    CFNotificationSuspensionBehavior behavior = CFNotificationSuspensionBehaviorDeliverImmediately;
    CFNotificationCenterAddObserver(distributedCenter,
                                    NULL,
                                    Callback,
                                    CFSTR("kLaunchAgentShowAboutWindow.miralem-cebic.de"),
                                    NULL,
                                    behavior);
}

int main(int argc, const char * argv[]) {

    [[LogManager sharedManager] logWithFormat:@"LaunchDaemon-Daemon"];

    NSRunLoop *runloop = [NSRunLoop mainRunLoop];
    [runloop run];
    
    [[LogManager sharedManager] logWithFormat:@"Starting LaunchDaemon-Daemon Cocoa application"];
//    int retVal = NSApplicationMain(argc, (const char **) argv);

    addCFNotificationCenterObserver();
    [Daemon sharedDaemon];

    [[LogManager sharedManager] logWithFormat:@"Cocoa application returned!?"];
    
    return 0;// retVal;
}