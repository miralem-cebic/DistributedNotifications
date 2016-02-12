/*
     File: LogManager.m
 Abstract: A singleton for logging.
  Version: 1.1
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 
 */

#import "LogManager.h"

#include <asl.h>


// --- ASL Log
@interface ASLLogManager : LogManager

@end

@implementation ASLLogManager {
    aslclient       _client;
    aslmsg          _messageTemplate;
}

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self->_client = asl_open(NULL, "Distributed Notification", 0);
        assert(self->_client != NULL);
        
        (void) asl_set_filter(self->_client, ASL_FILTER_MASK_UPTO(ASL_LEVEL_INFO));
        
        self->_messageTemplate = asl_new(ASL_TYPE_MSG);
        assert(self->_messageTemplate != NULL);
        
        // If you set state in the message template here then it'll be included in all 
        // messages logged.
    }
    return self;
}

- (void)dealloc
{
    if (self->_messageTemplate != NULL) {
        asl_free(self->_messageTemplate);
    }
    if (self->_client != NULL) {
        asl_close(self->_client);
    }
}

- (void)logWithFormat:(NSString *)format, ...
{
    va_list     ap;
    NSString *  str;
    
    va_start(ap, format);
    str = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);

    (void) asl_log(self->_client, self->_messageTemplate, ASL_LEVEL_INFO, "%s", [str UTF8String]);
}

@end







// --- NSLog
@interface NSLogManager : LogManager

- (void)logWithFormat:(NSString *)format, ...;

@end

@implementation NSLogManager

- (void)logWithFormat:(NSString *)format, ...;
{
    va_list     ap;
    
    va_start(ap, format);
    NSLogv(format, ap);
    va_end(ap);
}

@end






// --- Log Manager
@implementation LogManager

+ (LogManager *)sharedManager
{
    static dispatch_once_t  sOnceToken;
    static LogManager *     sLogManager;
    
    dispatch_once(&sOnceToken, ^{
        // Change the following to log via ASL (the default) or NSLog.
        if (YES) {
            sLogManager = [[ASLLogManager alloc] init];
        } else {
            //sLogManager = [[NSLogManager alloc] init];
        }
    });
    return sLogManager;
}

- (void)logWithFormat:(NSString *)format, ...
{
    #pragma unused(format)
    assert(NO);
}

@end
