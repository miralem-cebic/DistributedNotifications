//
//  StatusBar.m
//  DistributedNotifications
//
//  Created by Miralem Cebic on 12/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import "StatusBar.h"
#import <Cocoa/Cocoa.h>
#import "LogManager.h"
#import "NotificationsManager.h"
#include <CoreFoundation/CoreFoundation.h>

@interface StatusBar()
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, weak) IBOutlet NSMenu *statusMenu;

@end

@implementation StatusBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[LogManager sharedManager] logWithFormat:@"Status Bar loaded"];

        // ---
    }
    return self;
}

- (void)awakeFromNib
{
    [[LogManager sharedManager] logWithFormat:@"Status Bar Awake"];

    NSImage *statusImage = [NSImage imageNamed:@"launch-daemon-18x18"];
    statusImage.template = YES;

    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.menu = self.statusMenu;
    self.statusItem.highlightMode = YES;
    self.statusItem.image = statusImage;
}

- (IBAction)pressAbout:(NSMenuItem *)sender
{
    [[LogManager sharedManager] logWithFormat:@"Status Bar Clicked: 'About'"];
    [[LogManager sharedManager] logWithFormat:@"Sending Notification to LaunchDaemon ... "];

    [[NotificationsManager sharedInstance] postNotificationWithName:@"kLaunchAgentPostPressAbout"];
}

- (IBAction)pressDoSomething:(NSMenuItem *)sender
{
    [[LogManager sharedManager] logWithFormat:@"Status Bar Clicked: 'Do Something'"];
}

@end
