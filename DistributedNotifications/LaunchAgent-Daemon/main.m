//
//  main.m
//  LaunchAgent-Daemon
//
//  Created by Miralem Cebic on 12/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LogManager.h"

static void WaitForWindowServerSession(void)
// This routine waits for the window server to register its per-session
// services in our session.  This code was necessary in various pre-release
// versions of Mac OS X 10.5, but it is not necessary on the final version.
// However, I've left it in, and the option to enable it, to give me the
// flexibility to test this edge case.
{
    [[LogManager sharedManager] logWithFormat:@"Waiting for window server session begin"];

    do {
        NSDictionary *  sessionDict;

        sessionDict = CFBridgingRelease( CGSessionCopyCurrentDictionary() );
        if (sessionDict != nil) {
            break;
        }

        [[LogManager sharedManager] logWithFormat:@"No window server session, wait"];
        sleep(1);
    } while (YES);

    [[LogManager sharedManager] logWithFormat:@"Waiting for window server session end"];
}

int main(int argc, const char * argv[]) {

    [[LogManager sharedManager] logWithFormat:@"LaunchAgent-Daemon"];

    
    WaitForWindowServerSession();
    //InstallHandleSIGTERMFromRunLoop();


    [[LogManager sharedManager] logWithFormat:@"Starting LaunchAgent-Daemon Cocoa application"];
    int retVal = NSApplicationMain(argc, (const char **) argv);
    [[LogManager sharedManager] logWithFormat:@"Cocoa application returned!?"];

    return retVal;
}
