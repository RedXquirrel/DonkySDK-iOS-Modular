//
//  DNSystemHelpers.m
//  NAAS Core SDK Container
//
//  Created by Chris Watson on 27/02/2015.
//  Copyright (c) 2015 Donky Networks Ltd. All rights reserved.
//

#include <sys/sysctl.h>
#import <MacTypes.h>
#import "DNErrorController.h"
#import "DNSystemHelpers.h"
#import "DNLoggingController.h"

@implementation DNSystemHelpers

+ (BOOL)donkyIsDebuggerAttached {
    static BOOL debuggerIsAttached = NO;

    static dispatch_once_t debuggerPredicate;
    dispatch_once(&debuggerPredicate, ^{
        struct kinfo_proc info;
        size_t info_size = sizeof(info);
        int name[4];

        name[0] = CTL_KERN;
        name[1] = KERN_PROC;
        name[2] = KERN_PROC_PID;
        name[3] = getpid();

        if (sysctl(name, 4, &info, &info_size, NULL, 0) == -1) {
            DNDebugLog(@"[DonnkySDK] ERROR: Checking for a running debugger via sysctl() failed: %s", strerror(errno));
            debuggerIsAttached = false;
        }

        if (!debuggerIsAttached && (info.kp_proc.p_flag & P_TRACED) != 0)
            debuggerIsAttached = true;
    });

    return debuggerIsAttached;
}

+ (BOOL)donkySystemVersionAtLeast:(CGFloat)version {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= version;
}

+ (NSString *)generateGUID {

    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    NSString *guid = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, uuidRef));
    CFRelease(uuidRef);

    return guid;
}


@end
