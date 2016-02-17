//
//  Daemon.m
//  DistributedNotifications
//
//  Created by Miralem Cebic on 12/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import "Daemon.h"
#import "LogManager.h"

@implementation Daemon

+ (instancetype)sharedDaemon
{
    static Daemon *sharedDaemon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDaemon = [[self alloc] init];
    });
    return sharedDaemon;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[LogManager sharedManager] logWithFormat:@"Daemon init"];
    }
    return self;
}

- (void)showAboutEmpirumAgentInformation;
{
    [[LogManager sharedManager] logWithFormat:@"%s", __PRETTY_FUNCTION__];

    void *object;
    CFDictionaryRef userInfo;

    CFNotificationCenterRef distributedCenter = CFNotificationCenterGetDistributedCenter();
    CFNotificationCenterPostNotification(distributedCenter,
                                         CFSTR("kLaunchAgentShowAboutWindowNOW.miralem-cebic.de"),
                                         object,
                                         userInfo,
                                         true);
}

@end
