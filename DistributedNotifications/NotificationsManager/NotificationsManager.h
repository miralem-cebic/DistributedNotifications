//
//  NotificationsManager.h
//  DistributedNotifications
//
//  Created by Miralem Cebic on 17/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//
//  Code from: http://stackoverflow.com/questions/26637023/how-to-properly-use-cfnotificationcenteraddobserver-in-swift-for-ios

#import <Foundation/Foundation.h>

@interface NotificationsManager : NSObject

+ (instancetype)sharedInstance;

- (void)registerForNotificationName:(NSString *)name callback:(void (^)(void))callback;
- (void)postNotificationWithName:(NSString *)name;

@end
