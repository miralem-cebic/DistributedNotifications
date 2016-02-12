//
//  Daemon.h
//  DistributedNotifications
//
//  Created by Miralem Cebic on 12/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Daemon : NSObject

/**
 *  This method will return About Information to LaunchAgent via Notification
 */
- (void)showAboutEmpirumAgentInformation;

@end
