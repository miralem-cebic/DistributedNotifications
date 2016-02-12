//
//  main.m
//  LaunchDaemon-Daemon
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

static void InstallHandleSIGTERMFromRunLoop(void)
// This routine installs a SIGTERM handler that's called on the main thread, allowing
// it to then call into Cocoa to quit the app.
{
    static dispatch_once_t   sOnceToken;
    static dispatch_source_t sSignalSource;

    dispatch_once(&sOnceToken, ^{
        signal(SIGTERM, SIG_IGN);

        sSignalSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGTERM, 0, dispatch_get_main_queue());
        assert(sSignalSource != NULL);

        dispatch_source_set_event_handler(sSignalSource, ^{
            assert([NSThread isMainThread]);

            [[LogManager sharedManager] logWithFormat:@"Got SIGTERM"];

            [[NSApplication sharedApplication] terminate:nil];
        });

        dispatch_resume(sSignalSource);
    });
}


int main(int argc, const char * argv[]) {

    [[LogManager sharedManager] logWithFormat:@"LaunchDaemon-Daemon"];


    //WaitForWindowServerSession();
    //InstallHandleSIGTERMFromRunLoop();


    NSRunLoop *runloop = [NSRunLoop mainRunLoop];
    [runloop run];
    
    [[LogManager sharedManager] logWithFormat:@"Starting LaunchDaemon-Daemon Cocoa application"];
    int retVal = NSApplicationMain(argc, (const char **) argv);
    [[LogManager sharedManager] logWithFormat:@"Cocoa application returned!?"];
    
    return retVal;
}