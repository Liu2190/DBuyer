//
//  DExceptionHandleCore.m
//  ControlDemo
//
//  Created by dilei liu on 14-2-26.
//  Copyright (c) 2014年 dilei liu. All rights reserved.
//

#import "TExceptionHandleCore.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

NSString * const UncaughtExceptionHandlerSignalExceptionName_ = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey_ = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey_ = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount_ = 0;
const int32_t UncaughtExceptionMaximum_ = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount_ = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount_ = 5;

@implementation TExceptionHandleCore

+ (NSArray *)backtrace {
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    int i;
    
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = UncaughtExceptionHandlerSkipAddressCount_;
         i < UncaughtExceptionHandlerSkipAddressCount_+UncaughtExceptionHandlerReportAddressCount_; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    
    free(strs);
    return backtrace;
}

- (void)senderExceptionMessage2Server:(NSString*)exceptionReason {
    
}

- (void)goonAppOrBypass {
    
}

- (void)closeAppOrReboot {
    
}

- (void)handleException:(NSException *)exception {
    NSString *title = @"系统运行警告";
    // NSString *addressesKey = [[exception userInfo]objectForKey:UncaughtExceptionHandlerAddressesKey_];
    NSString *reason = [exception reason];
    /*NSString *message = [NSString stringWithFormat:@"如果点击继续，程序有可能会出现其他的问题，建议您还是点击退出按钮并重新打开\n\n异常原因如下:\n%@\n%@",
                         reason,addressesKey];*/
    NSString *message = [NSString stringWithFormat:@"如果点击继续，系统有可能会出现其他的问题，建议您还是点击退出按钮并重新打开"];
    
    
    [self senderExceptionMessage2Server:reason];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self
                                             cancelButtonTitle:@"退出" otherButtonTitles:@"继续", nil];
    [alertView show];
    
    
    dismissed = YES;
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    while (dismissed) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((__bridge CFStringRef)mode, 0.001, false);
        }
    }
    
    CFRelease(allModes);
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName_]) {
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey_] intValue]);
    } else {
        [exception raise];
    }
}

- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex {
    if (anIndex == 0) { // 立即退出(如果能重启)
        [self closeAppOrReboot];
    } else if (anIndex == 1){ // 继续执行
        [self goonAppOrBypass];
    }
}


void handleException(NSException *exception) {
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount_);
    if (exceptionCount > UncaughtExceptionMaximum_) {
        return;
    }
    
    NSArray *callStack = [TExceptionHandleCore backtrace];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey_];
    
    [[[TExceptionHandleCore alloc] init] performSelectorOnMainThread:@selector(handleException:)
                                                          withObject:[NSException exceptionWithName:[exception name] reason:[exception reason] userInfo:userInfo]
                                                       waitUntilDone:YES];
}



void signalHandler(int signal) {
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount_);
    if (exceptionCount > UncaughtExceptionMaximum_) {
        return;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey_];
    NSArray *callStack = [TExceptionHandleCore backtrace];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey_];
    
    [[[TExceptionHandleCore alloc] init] performSelectorOnMainThread:@selector(handleException:)
                                                          withObject: [NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName_ reason: [NSString stringWithFormat:NSLocalizedString(@"Signal %d was raised.", nil),signal] userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey_]]
                                                       waitUntilDone:YES];
}

- (void)installUncaughtExceptionHandler {
    NSSetUncaughtExceptionHandler(&handleException);
    signal(SIGABRT, signalHandler);
	signal(SIGILL, signalHandler);
	signal(SIGSEGV, signalHandler);
	signal(SIGFPE, signalHandler);
	signal(SIGBUS, signalHandler);
	signal(SIGPIPE, signalHandler);
}

@end
