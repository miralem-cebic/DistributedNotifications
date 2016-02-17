//
//  Panel.m
//  DistributedNotifications
//
//  Created by Miralem Cebic on 12/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import "Panel.h"
#import <Cocoa/Cocoa.h>
#import "LogManager.h"

@interface Panel()
@property (weak) IBOutlet NSPanel *panel;
@property (weak) IBOutlet NSProgressIndicator *progress;

@end

@implementation Panel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[LogManager sharedManager] logWithFormat:@"Panel init"];
    }
    return self;
}

- (void)awakeFromNib
{
    [[LogManager sharedManager] logWithFormat:@"Panel Awake"];

    return;
}

- (void)showAboutWindowWithInformation:(NSDictionary *)aboutInformation
{
    [[LogManager sharedManager] logWithFormat:@"Panel Show About Window"];

    [self.panel makeKeyAndOrderFront:self];

    // We have to call -[NSWindow setCanBecomeVisibleWithoutLogin:] to let the
    // system know that we're not accidentally trying to display a window
    // pre-login.

    [self.panel setCanBecomeVisibleWithoutLogin:YES];

    // Our application is a UI element which never activates, so we want our
    // panel to show regardless.

    [self.panel setHidesOnDeactivate:YES];

    // Due to a problem with the relationship between the UI frameworks and the
    // window server <rdar://problem/5136400>, -[NSWindow orderFront:] is not
    // sufficient to show the window.  We have to use -[NSWindow orderFrontRegardless].
    [self.panel orderFrontRegardless];

    [[LogManager sharedManager] logWithFormat:@"Display About Window"];
    
    [NSApp activateIgnoringOtherApps:YES];
}

@end
