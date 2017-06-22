//
//  DExceptionHandleController.h
//  ControlDemo
//
//  Created by dilei liu on 14-2-26.
//  Copyright (c) 2014年 dilei liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TExceptionHandleCore.h"

@interface TExceptionHandle : TExceptionHandleCore {

}

+ (id)getInstance;
- (void)installUncaughtExceptionHandler;


@end
