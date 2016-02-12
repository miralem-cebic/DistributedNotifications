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
    [[LogManager sharedManager] logWithFormat:@"Awake"];

    NSImage *statusImage = [NSImage imageNamed:@"launch-daemon-18x18"];
    statusImage.template = YES;

    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.menu = self.statusMenu;
    self.statusItem.highlightMode = YES;
    self.statusItem.image = statusImage;

    return;
}

- (IBAction)pressAbout:(NSMenuItem *)sender
{
    [[LogManager sharedManager] logWithFormat:@"Clicked: 'About'"];
    [[LogManager sharedManager] logWithFormat:@"Sending Notification to LaunchDaemon ... "];
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"kLaunchAgentShowAboutWindow"
                                                                   object:nil userInfo:nil deliverImmediately:YES];
}

- (IBAction)pressDoSomething:(NSMenuItem *)sender
{
    [[LogManager sharedManager] logWithFormat:@"Clicked: 'Do Something'"];
}

@end
