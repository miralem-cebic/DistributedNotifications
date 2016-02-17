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
#import "NotificationsManager.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet Panel *panel;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[LogManager sharedManager] logWithFormat:@"6- Did finish launching begin"];
    [self addCFNotificationCenterObserver];
}

- (void)applicationWillTerminate:(NSNotification *)note
{
    [[LogManager sharedManager] logWithFormat:@"Will terminate"];
}
@end
