//
//  main.m
//  LaunchDaemon-Daemon
//
//  Created by Miralem Cebic on 12/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Daemon.h"
#import "LogManager.h"
#import "NotificationsManager.h"

int main(int argc, const char * argv[]) {

    [[LogManager sharedManager] logWithFormat:@"LaunchDaemon-Daemon"];

    [[LogManager sharedManager] logWithFormat:@"Starting LaunchDaemon-Daemon Cocoa application"];

    [Daemon sharedDaemon];

    [[LogManager sharedManager] logWithFormat:@"Cocoa application returned!?"];

    CFRunLoopRun();
    return 0;
}