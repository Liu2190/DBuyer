//
//  DExceptionHandleController.m
//  ControlDemo
//
//  Created by dilei liu on 14-2-26.
//  Copyright (c) 2014年 dilei liu. All rights reserved.
//

#import "TExceptionHandle.h"

static TExceptionHandle *instance;
@implementation TExceptionHandle


+ (id)getInstance {
    @synchronized(self) {
        if (instance == nil)
            instance = [[self alloc] init];
    }
    
    return instance;
}

- (void)installUncaughtExceptionHandler {
    [super installUncaughtExceptionHandler];
}


- (void)senderExceptionMessage2Server:(NSString *)exceptionReason {// 发送异常信息给服务器存储
    
}

- (void)goonAppOrBypass { // 退出程序或者重启
    
}

- (void)closeAppOrReboot { // 绕过异常继续执行
    
}

@end
