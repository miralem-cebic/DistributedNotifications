//
//  AppDelegate.m
//  LaunchAgent-Daemon
//
//  Created by Miralem Cebic on 12/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import "AppDelegate.h"
#import "LogManager.h"
#import "Panel.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet Panel *panel;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[LogManager sharedManager] logWithFormat:@"Did finish launching begin"];
    [self addCFNotificationCenterObserver];
}

- (void)applicationWillTerminate:(NSNotification *)note
{
    [[LogManager sharedManager] logWithFormat:@"Will terminate"];
}

void notificationCallback (CFNotificationCenterRef center,
                           void * observer,
                           CFStringRef name,
                           const void * object,
                           CFDictionaryRef userInfo) {

    [[LogManager sharedManager] logWithFormat:@"Recieved Notification from LaunchDeamon"];

    AppDelegate *delegate = [NSApplication sharedApplication].delegate;
    Panel *panel = delegate->_panel;
    NSDictionary *userInfoDict = (__bridge NSDictionary *)userInfo;

    [panel showAboutWindowWithInformation:userInfoDict];
}

- (void)addCFNotificationCenterObserver
{
    CFNotificationCenterRef center = CFNotificationCenterGetLocalCenter();
    // add an observer
    CFNotificationCenterAddObserver(center, NULL, notificationCallback,
                                    CFSTR("kLaunchAgentShowAboutWindowNOW.miralem-cebic.de"), NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
}

@end
