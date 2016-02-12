//
//  AppDelegate.m
//  LaunchDaemon-Daemon
//
//  Created by Miralem Cebic on 12/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import "AppDelegate.h"
#import "LogManager.h"
#import "Daemon.h"

@interface AppDelegate ()
@property (nonatomic, strong) Daemon *daemon;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[LogManager sharedManager] logWithFormat:@"Did finish launching begin"];
    _daemon = [Daemon new];
    [self addCFNotificationCenterObserver];
}

- (void)applicationWillTerminate:(NSNotification *)note
{
    [[LogManager sharedManager] logWithFormat:@"Will terminate"];
}

static void Callback(CFNotificationCenterRef center,
                     void *observer,
                     CFStringRef name,
                     const void *object,
                     CFDictionaryRef userInfo)
{
    [[LogManager sharedManager] logWithFormat:@"Recieved Notification from LaunchAgent"];

    AppDelegate *delegate = [NSApplication sharedApplication].delegate;
    Daemon *daemon = delegate->_daemon;
    NSDictionary *userInfoDict = (__bridge NSDictionary *)userInfo;
    [daemon showAboutEmpirumAgentInformation];

}

- (void)addCFNotificationCenterObserver
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

@end
