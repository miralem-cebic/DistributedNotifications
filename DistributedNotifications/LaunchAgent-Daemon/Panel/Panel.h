//
//  Panel.h
//  DistributedNotifications
//
//  Created by Miralem Cebic on 12/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Panel : NSObject

/**
 *  Will display About Window with Information
 *
 *  @param aboutInformation Notifications User Info Dictionary
 */
- (void)showAboutWindowWithInformation:(NSDictionary *)aboutInformation;

@end
