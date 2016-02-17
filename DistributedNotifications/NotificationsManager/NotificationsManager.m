//
//  NotificationsManager.m
//  DistributedNotifications
//
//  Created by Miralem Cebic on 17/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import "NotificationsManager.h"
#import "LogManager.h"

@interface NotificationsManager ()
@property (nonatomic, strong) NSMutableDictionary *dictHandlers;
@end

@implementation NotificationsManager

+ (instancetype)sharedInstance
{
    static id instance = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dictHandlers = [NSMutableDictionary dictionary];
        [[LogManager sharedManager] logWithFormat:@"%s", __PRETTY_FUNCTION__];
    }
    return self;
}

- (void)registerForNotificationName:(NSString *)name callback:(void (^)(void))callback
{
    _dictHandlers[name] = callback;
    CFNotificationCenterRef center = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(center,
                                    (__bridge const void *)(self),
                                    defaultNotificationCallback,
                                    (__bridge CFStringRef)name,
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);

    [[LogManager sharedManager] logWithFormat:@"%s", __PRETTY_FUNCTION__];
}

- (void)postNotificationWithName:(NSString *)name
{
    CFNotificationCenterRef center = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterPostNotification(center, (__bridge CFStringRef)name, NULL, NULL, YES);

    [[LogManager sharedManager] logWithFormat:@"%s", __PRETTY_FUNCTION__];
}

- (void)notificationCallbackReceivedWithName:(NSString *)name
{
    void (^callback)(void) = _dictHandlers[name];
    callback();

    [[LogManager sharedManager] logWithFormat:@"%s", __PRETTY_FUNCTION__];
}

void defaultNotificationCallback (CFNotificationCenterRef center,
                                  void *observer,
                                  CFStringRef name,
                                  const void *object,
                                  CFDictionaryRef userInfo)
{
    [[LogManager sharedManager] logWithFormat:@"%s", __PRETTY_FUNCTION__];
    [[LogManager sharedManager] logWithFormat:@"Name: %@, userinfo: %@", name, userInfo];

    NSString *identifier = (__bridge NSString *)name;
    [[NotificationsManager sharedInstance] notificationCallbackReceivedWithName:identifier];
}


- (void)dealloc {
    CFNotificationCenterRef center = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterRemoveEveryObserver(center, (__bridge const void *)(self));
}

@end
